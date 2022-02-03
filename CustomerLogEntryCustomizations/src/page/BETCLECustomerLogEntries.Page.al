/// <summary>
/// Page BET CLE Customer Log Entries (ID 64851).
/// </summary>
page 64851 "BET CLE Customer Log Entries"
{
    ApplicationArea = All;
    Caption = 'Customer Log Entries';
    PageType = List;
    SourceTable = "BET CLE Customer Log Entry";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Page"; Rec."Source Page")
                {
                    ToolTip = 'Specifies the value of the Source Page field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Operation Type"; Rec."Operation Type")
                {
                    ToolTip = 'Specifies the value of the Operation Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of Modification"; Rec."Date of Modification")
                {
                    ToolTip = 'Specifies the value of the Date of Modification field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Time of Modification"; Rec."Time of Modification")
                {
                    ToolTip = 'Specifies the value of the Time of Modification field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson/Purchaser Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}