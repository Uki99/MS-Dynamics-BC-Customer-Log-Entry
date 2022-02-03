/// <summary>
/// PageExtension BET CLE Customer Card Ext (ID 64852) extends Record Customer Card.
/// </summary>
pageextension 64852 "BET CLE Customer Card Ext" extends "Customer Card"
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