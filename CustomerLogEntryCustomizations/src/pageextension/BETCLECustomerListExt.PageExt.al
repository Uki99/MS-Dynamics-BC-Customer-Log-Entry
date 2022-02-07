/// <summary>
/// PageExtension BET CLE Customer List Ext (ID 64851) extends Record Customer List.
/// </summary>
pageextension 64851 "BET CLE Customer List Ext" extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action("BET CLE Log Entry")
            {
                ApplicationArea = All;
                Caption = 'Log Entry';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Find;
                ToolTip = 'Executes the Log Entry action.';

                RunObject = Page "BET CLE Customer Log Entries";
                RunPageLink = "Customer No." = field("No.");
            }
        }
        addlast(Reporting)
        {
            action("BET CLE Print Log Entries")
            {
                ApplicationArea = All;
                Caption = 'Print Log Entries';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = ReviewWorksheet;
                ToolTip = 'Executes the Print Log Entries action.';

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    CurrPage.SetSelectionFilter(Customer);
                    Report.Run(Report::"BET CLE Customers Log Entries", true, true, Customer);
                end;
            }
        }
    }
}