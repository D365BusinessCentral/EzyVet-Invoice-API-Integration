codeunit 50072 "EzyVet Get Invoices"
{
    trigger OnRun()
    begin
        //Check Setups
        gConnectionThershold := 75;
        InvoiceIntegrationLog.InsertLogs('Invoice API Setups check started', 'SUCCESS');
        InvoiceAPIIntegration.CheckSetup(gErrorMsgonSetups);
        if gErrorMsgonSetups = '' then
            InvoiceIntegrationLog.InsertLogs('Invoice  API Setups check finished', 'SUCCESS')
        else begin
            InvoiceIntegrationLog.InsertLogs(gErrorMsgonSetups, 'ERROR');
            exit;
        end;

        //Get Access Token
        InvoiceIntegrationLog.InsertLogs('Retrieve API Access Token is initiated', 'SUCCESS');
        InvoiceAPIIntegration.GetAccessToken(gAccessToken, gErrorMsgonAccessTokenRetrieval);
        if gErrorMsgonAccessTokenRetrieval = '' then
            InvoiceIntegrationLog.InsertLogs('Retrieve API Access Token is completed', 'SUCCESS')
        else begin
            InvoiceIntegrationLog.InsertLogs(gErrorMsgonAccessTokenRetrieval, 'ERROR');
            exit;
        end;

        //Assign Filters
        if gIsAuto then begin
            APIConfiguration.Get();
            if APIConfiguration.last_invoice_retrieval_date = 0 then
                gFromDate := 0
            else
                gFromDate := APIConfiguration.last_invoice_retrieval_date;

            gToDate := EpochConverter.SystemDateTimeToEpochDateTime(CurrentDateTime);

        end;

        gfilters := StrSubstNo('{">=":%1,"<=":%2}', gFromDate, gToDate);

        //Retrieve New Records
        if gGetNewRecords then begin
            Clear(gRecordsCount);
            InvoiceIntegrationLog.InsertLogs('Checking for new Invoice is initiated', 'SUCCESS');
            InvoiceAPIIntegration.GetInvoiceListPages(gAccessToken, gRecordType::New, gFilters, gTotalPageCount, gErrorMsgonPagesCount);
            if gErrorMsgonPagesCount = '' then
                InvoiceIntegrationLog.InsertLogs(StrSubstNo('%1 pages retrieved for new Invoices', gTotalPageCount), 'SUCCESS')
            else begin
                InvoiceIntegrationLog.InsertLogs(gErrorMsgonPagesCount, 'ERROR');
                exit;
            end;

            if gTotalPageCount >= 1 then begin
                InvoiceIntegrationLog.InsertLogs('New Invoices Retrieval started', 'SUCCESS');
                GetNewInvoiceList(gRecordType::New, gFromDate, gToDate, gErrorMsgonInvoiceInsert);
                if gErrorMsgonInvoiceInsert = '' then
                    InvoiceIntegrationLog.InsertLogs(StrSubstNo('%1 new Invoices retrieved', gRecordsCount), 'SUCCESS')
                else begin
                    InvoiceIntegrationLog.InsertLogs(gErrorMsgonInvoiceInsert, 'ERROR');
                    exit;
                end;
            end;
        end;


        //Retrieve Modified Records
        if gGetModifiedRecords then begin
            Clear(gRecordsCount);
            Clear(gTotalPageCount);
            Clear(gErrorMsgonPagesCount);
            if gFromDate <> 0 then begin
                InvoiceIntegrationLog.InsertLogs('Checking for modified Invoices is initiated ', 'SUCCESS');
                InvoiceAPIIntegration.GetInvoiceListPages(gAccessToken, gRecordType::Modified, gFilters, gTotalPageCount, gErrorMsgonPagesCount);
                if gErrorMsgonPagesCount = '' then
                    InvoiceIntegrationLog.InsertLogs(StrSubstNo('%1 pages retrieved for modified Invoices', gTotalPageCount), 'SUCCESS')
                else begin
                    InvoiceIntegrationLog.InsertLogs(gErrorMsgonPagesCount, 'ERROR');
                    exit;
                end;

                if gTotalPageCount >= 1 then begin
                    InvoiceIntegrationLog.InsertLogs(StrSubstNo('Modified Invoices Retrieval started'), 'SUCCESS');
                    GetNewInvoiceList(gRecordType::Modified, gFromDate, gToDate, gErrorMsgonInvoiceInsert);
                    if gErrorMsgonInvoiceInsert = '' then
                        InvoiceIntegrationLog.InsertLogs(StrSubstNo('%1 modified Invoices retrieved', gRecordsCount), 'SUCCESS')
                    else begin
                        InvoiceIntegrationLog.InsertLogs(gErrorMsgonInvoiceInsert, 'ERROR');
                        exit;
                    end;
                end;
            end;
        end;


        if gIsAuto then begin
            APIConfiguration.last_invoice_retrieval_date := gToDate;
            APIConfiguration.Modify();
        end;

    end;

    procedure GetNewInvoiceList(lRecordType: Option New,Modified; lFromDate: Integer; lToDate: integer; var lErrorMsgonProductInsert: Text)
    var
        lhttpClient: HttpClient;
        lhttpContent: HttpContent;
        lhttpHeaders: HttpHeaders;
        lhttpResponseMessage: HttpResponseMessage;
        lresponseText: Text;
        lFilters: Text;
        i: Integer;
        j: Integer;
        lRecordsCount: Integer;

    begin
        APIConfiguration.Get();
        i := 0;
        gPageCount := 0;
        gStopLoop := false;
        if gTotalPageCount > gConnectionThershold then
            gTimesofCalls := Round(gTotalPageCount / gConnectionThershold, 1, '>')
        else
            gTimesofCalls := 1;
        repeat
            j += 1;
            gPageCount += gConnectionThershold;
            repeat
                i += 1;
                if lRecordType = lRecordType::New then
                    lFilters := 'limit=200&' + StrSubstNo('ownership_id=%1&', APIConfiguration."Ownership ID") + StrSubstNo('page=%1&', i) + 'created_at=' + gfilters;
                if lRecordType = lRecordType::Modified then
                    lFilters := 'limit=200&' + StrSubstNo('ownership_id=%1&', APIConfiguration."Ownership ID") + StrSubstNo('page=%1&', i) + 'modified_at=' + gfilters;

                Clear(lhttpContent);
                Clear(lhttpClient);
                Clear(lhttpResponseMessage);
                Clear(lresponseText);
                lhttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + FORMAT(gAccessToken));
                if lhttpClient.Get(APIConfiguration.invoice_url + lFilters, lhttpResponseMessage) then begin
                    lhttpResponseMessage.Content.ReadAs(lresponseText);
                    InsertInvoices.InsertInvoices(lresponseText, lRecordType, lRecordsCount);
                end else
                    Error(FORMAT(lhttpResponseMessage.Content));
                gStopLoop := (i = gPageCount) or (i = gtotalPageCount);
                gRecordsCount += lRecordsCount;
            until gStopLoop = true;

            if not (j = gTimesofCalls) then
                Sleep(60000);
        until j = gTimesofCalls;
    end;

    procedure SetParameters(lFromDate: Integer; lToDate: Integer; lIsAuto: Boolean; lGetNewRecords: Boolean; lGetModifiedRecords: Boolean)
    begin
        gFromDate := lFromDate;
        gToDate := lToDate;
        gIsAuto := lIsAuto;
        gGetNewRecords := lGetNewRecords;
        gGetModifiedRecords := lGetModifiedRecords;


    end;

    var
        InvoiceAPIIntegration: Codeunit "EzyVet Invoice API Integration";
        InsertInvoices: Codeunit "EzyVet Insert Invoices";
        gRecordType: Option New,Modified;
        gTotalPageCount: Integer;
        gPageCount: Integer;
        gStopLoop: Boolean;
        gConnectionThershold: Integer;
        gTimesofCalls: Integer;
        gAccessToken: Text;
        gErrorMsgonAccessTokenRetrieval: text;
        gErrorMsgonPagesCount: text;
        gFromDate: Integer;
        gToDate: Integer;
        gIsAuto: Boolean;
        gErrorMsgonSetups: Text;
        InvoiceIntegrationLog: Codeunit EzyVetInvoiceIntegrationLogs;
        APIConfiguration: Record "EzyVet API Configuration";
        EpochConverter: Codeunit "EzyVet Epoch Convertor";
        gfilters: Text;
        gErrorMsgonInvoiceInsert: Text;
        gRecordsCount: Integer;
        gGetNewRecords: Boolean;
        gGetModifiedRecords: Boolean;

}

