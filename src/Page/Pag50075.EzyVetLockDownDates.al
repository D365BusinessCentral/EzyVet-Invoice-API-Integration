page 50075 EzyVetLockDownDates
{

    ApplicationArea = All;
    Caption = 'EzyVetLockDownDates';
    PageType = List;
    SourceTable = "EzyVet Lock Down Dates";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FY Year"; Rec."FY Year")
                {
                    ToolTip = 'Specifies the value of the FY Year field';
                    ApplicationArea = All;
                }
                field("Transaction Locked Date"; Rec."Transaction Locked Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Locked Date field';
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field';
                    ApplicationArea = All;
                }
                field("Day No."; Rec."Day No.")
                {
                    ToolTip = 'Specifies the value of the Day No. field';
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field';
                    ApplicationArea = All;
                }
                field("Week No."; Rec."Week No.")
                {
                    ToolTip = 'Specifies the value of the Week No. field';
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
