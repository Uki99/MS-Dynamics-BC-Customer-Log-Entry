/// <summary>
/// TableExtension BET CLE Customer Ext. (ID 64851) extends Record Customer.
/// </summary>
tableextension 64851 "BET CLE Customer Ext." extends Customer
{
    fields
    {
        field(64851; "BET CLE No. of Log Entries"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'No. of Log Entries';
            CalcFormula = count("BET CLE Customer Log Entry" where("Customer No." = field("No.")));
            TableRelation = "BET CLE Customer Log Entry" where("Customer No." = field("No."));
        }
    }
}