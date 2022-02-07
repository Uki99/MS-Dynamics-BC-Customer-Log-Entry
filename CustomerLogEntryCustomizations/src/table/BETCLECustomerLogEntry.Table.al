/// <summary>
/// Table BET CLE Customer Log Entry (ID 64851).
/// </summary>
table 64851 "BET CLE Customer Log Entry"
{
    DataClassification = CustomerContent;
    LookupPageId = "BET CLE Customer Log Entries";
    DrillDownPageId = "BET CLE Customer Log Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Entry No.';
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;

            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }
        field(4; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "Source Page"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Page';
        }
        field(6; "Operation Type"; Enum "BET CLE Operation Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Operation Type';
        }
        field(7; "Time of Modification"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time of Modification';
        }
        field(8; "Date of Modification"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Modification';
        }
        field(9; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(10; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salesperson/Purchaser Code';
            FieldClass = FlowField;

            CalcFormula = lookup("User Setup"."Salespers./Purch. Code" where("User ID" = field("User ID")));
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Customer No.", "Operation Type") { }
    }

    trigger OnInsert()
    begin
        GetUserId();
    end;

    local procedure GetUserId()
    //var
    //User: Record User;
    begin
        //User.Get();
        //Rec."User ID" := User."User Name";
        Rec."User ID" := CopyStr(UserId(), 1, MaxStrLen(Rec."User ID"));
    end;
}