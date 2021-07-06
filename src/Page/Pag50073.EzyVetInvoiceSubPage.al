page 50073 "EzyVet Invoice SubPage"
{

    Caption = 'EzyVet Invoice SubPage';
    PageType = ListPart;
    SourceTable = "EzyVet Invoice Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(invoice_id; Rec.invoice_id)
                {
                    ToolTip = 'Specifies the value of the contact_id field';
                    ApplicationArea = All;
                }
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
                field(ownership_id; Rec.ownership_id)
                {
                    ToolTip = 'Specifies the value of the ownerwship_id field';
                    ApplicationArea = All;
                }
                field(location_id; Rec.location_id)
                {
                    ToolTip = 'Specifies the value of the location_id field';
                    ApplicationArea = All;
                }
                field(product_id; Rec.product_id)
                {
                    ToolTip = 'Specifies the value of the product_id field';
                    ApplicationArea = All;
                }
                field(quantity; Rec.quantity)
                {
                    ToolTip = 'Specifies the value of the quantity field';
                    ApplicationArea = All;
                }
                field(tax_code; Rec.tax_code)
                {
                    ToolTip = 'Specifies the value of the tax_code field';
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ToolTip = 'Specifies the value of the status field';
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
                field(staff_user_id; Rec.staff_user_id)
                {
                    ToolTip = 'Specifies the value of the staff_user_id field';
                    ApplicationArea = All;
                }
                field(name; rec.name)
                {
                    ToolTip = 'Specifies the value of the name field';
                    ApplicationArea = All;

                }
                field(discount; rec.discount)
                {
                    ToolTip = 'Specifies the value of the discount field';
                    ApplicationArea = All;

                }
                field(price; rec.price)
                {
                    ToolTip = 'Specifies the value of the price field';
                    ApplicationArea = All;

                }
                field(Dispense; rec.Dispense)
                {
                    ToolTip = 'Specifies the value of the Dispense field';
                    ApplicationArea = all;
                }
                field(price_tax; rec.price_tax)
                {
                    ToolTip = 'Specifies the value of the price_tax field';
                    ApplicationArea = All;

                }
                field(standard_price; rec.standard_price)
                {
                    ToolTip = 'Specifies the value of the standard_price field';
                    ApplicationArea = All;

                }
                field(standard_price_tax; rec.standard_price_tax)
                {
                    ToolTip = 'Specifies the value of the standard_price_tax field';
                    ApplicationArea = All;

                }
                field(total; rec.total)
                {
                    ToolTip = 'Specifies the value of the total field';
                    ApplicationArea = All;

                }
                field(total_tax; rec.total_tax)
                {
                    ToolTip = 'Specifies the value of the total_tax field';
                    ApplicationArea = All;

                }
                field(tax_percent; rec.tax_percent)
                {
                    ToolTip = 'Specifies the value of the tax_percent field';
                    ApplicationArea = All;

                }
                field(animal_id; rec.animal_id)
                {
                    ToolTip = 'Specifies the value of the animal_id field';
                    ApplicationArea = All;

                }
                field(consult_id; rec.consult_id)
                {
                    ToolTip = 'Specifies the value of the consult_id field';
                    ApplicationArea = All;

                }
            }
        }
    }

}
