/// <summary>
/// Codeunit Customer Log Manangement (ID 64851).
/// </summary>
codeunit 64851 "Customer Log Manangement"
{
    /// <summary>
    /// InsertCustomerLogEntry.
    /// </summary>
    /// <param name="Customer No.">Code[20].</param>
    /// <param name="Description">Text[100].</param>
    /// <param name="Source Page">Integer.</param>
    /// <param name="Operation Type">Enum "BET CLE Operation Type".</param>
    procedure InsertCustomerLogEntry("Customer No.": Code[20]; Description: Text[100]; "Source Page": Integer; "Operation Type": Enum "BET CLE Operation Type")
    begin
        Error('Implement');
    end;
}