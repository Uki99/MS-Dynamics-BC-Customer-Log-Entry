/// <summary>
/// PageExtension BET CLE Customer Card Ext (ID 64852) extends Record Customer Card.
/// </summary>
pageextension 64852 "BET CLE Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("BET CLE No. of Log Entries"; Rec."BET CLE No. of Log Entries")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. of Log Entries field.';
                Editable = false;
                Importance = Promoted;
            }
        }
    }
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
            action("BET CLE Show Last Modified")
            {
                ApplicationArea = All;
                Caption = 'Show Last Modified';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Action;
                ToolTip = 'Executes the Show Last Modified action.';

                trigger OnAction()
                var
                    CustomerLogManangement: Codeunit "Customer Log Manangement";
                begin
                    Message('Last Date Modified: %1', CustomerLogManangement.FindLastLogInserted(Rec."No."));
                end;
            }
        }
    }
}