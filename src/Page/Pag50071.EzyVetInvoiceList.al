page 50071 EzyVetInvoiceList
{

    ApplicationArea = All;
    Caption = 'EzyVet Invoice List';
    PageType = List;
    SourceTable = "EzyVet Invoice Header";
    UsageCategory = Lists;
    CardPageId = "EzyVet Invoice Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field';
                    ApplicationArea = All;
                }
                field(active; Rec.active)
                {
                    ToolTip = 'Specifies the value of the active field';
                    ApplicationArea = All;
                }
                field(created_at; Rec.created_at)
                {
                    ToolTip = 'Specifies the value of the created_at field';
                    ApplicationArea = All;
                }
                field(modified_at; Rec.modified_at)
                {
                    ToolTip = 'Specifies the value of the modified_at field';
                    ApplicationArea = All;
                }
                field(ownership_id; Rec.ownership_id)
                {
                    ToolTip = 'Specifies the value of the ownerwship_id field';
                    ApplicationArea = All;
                }
                field(code; Rec.code)
                {
                    ToolTip = 'Specifies the value of the code field';
                    ApplicationArea = All;
                }
                field(subtotal; Rec.subtotal)
                {
                    ToolTip = 'Specifies the value of the subtotal field';
                    ApplicationArea = All;
                }
                field(tax; Rec.tax)
                {
                    ToolTip = 'Specifies the value of the tax field';
                    ApplicationArea = All;
                }
                field(contact_id; Rec.contact_id)
                {
                    ToolTip = 'Specifies the value of the contact_id field';
                    ApplicationArea = All;
                }
                field(animal_id; Rec.animal_id)
                {
                    ToolTip = 'Specifies the value of the animal_id field';
                    ApplicationArea = All;
                }
                field(consult_id; Rec.consult_id)
                {
                    ToolTip = 'Specifies the value of the consult_id field';
                    ApplicationArea = All;
                }
                field(payment_terms_id; Rec.payment_terms_id)
                {
                    ToolTip = 'Specifies the value of the payment_terms_id field';
                    ApplicationArea = All;
                }
                field(includes_tax; Rec.includes_tax)
                {
                    ToolTip = 'Specifies the value of the includes_tax field';
                    ApplicationArea = All;
                }
                field(date; Rec.date)
                {
                    ToolTip = 'Specifies the value of the date field';
                    ApplicationArea = All;
                }
                field(due_date; Rec.due_date)
                {
                    ToolTip = 'Specifies the value of the date_due field';
                    ApplicationArea = All;
                }
                field(customer_reference_number; Rec.customer_reference_number)
                {
                    ToolTip = 'Specifies the value of the customer_reference_number field';
                    ApplicationArea = All;
                }
                field(limit; Rec.limit)
                {
                    ToolTip = 'Specifies the value of the limit field';
                    ApplicationArea = All;
                }
                field(page; Rec.page)
                {
                    ToolTip = 'Specifies the value of the page field';
                    ApplicationArea = All;
                }
                field(created_at_date; rec.created_at_date)
                {
                    ToolTip = 'Specifies the value of the created_at_date field';
                    ApplicationArea = All;

                }
                field(modified_at_date; rec.modified_at_date)
                {
                    ToolTip = 'Specifies the value of the modified_at_date field';
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetInvoices)
            {
                Caption = 'Get Invoice';
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GetInvoice: Report EzyVetGetInvoices;
                begin
                    GetInvoice.RunModal();
                end;
            }
            action(CreateInvoices)
            {
                Caption = 'Create Invoice';
                Image = Create;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CreateInvoice: Codeunit "EzyVet Init Invoices";
                begin
                    CreateInvoice.SetParameters(Rec.entry_no);
                    //CreateInvoice.ValidateInvoices(Rec);
                    CreateInvoice.InitInvoiceRecords();
                end;
            }
        }
    }

}
