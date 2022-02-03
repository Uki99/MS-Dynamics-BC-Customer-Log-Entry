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
    }
}