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
    var
        BETCLECustomerLogEntry: Record "BET CLE Customer Log Entry";
    begin
        BETCLECustomerLogEntry.Init();
        BETCLECustomerLogEntry."Customer No." := "Customer No.";
        BETCLECustomerLogEntry.Description := Description;
        BETCLECustomerLogEntry."Source Page" := "Source Page";
        BETCLECustomerLogEntry."Operation Type" := "Operation Type";

        InitEntryDateAndTime(BETCLECustomerLogEntry);
        InitEntryNo(BETCLECustomerLogEntry);
        BETCLECustomerLogEntry.Insert(true);
    end;

    /// <summary>
    /// DeleteCustomerLogEntry.
    /// </summary>
    /// <param name="Customer No.">Code[20].</param>
    procedure DeleteCustomerLogEntry("Customer No.": Code[20])
    var
        BETCLECustomerLogEntry: Record "BET CLE Customer Log Entry";
    begin
        BETCLECustomerLogEntry.SetRange("Customer No.", "Customer No.");
        BETCLECustomerLogEntry.FindSet(true, false);
        BETCLECustomerLogEntry.DeleteAll();
    end;

    /// <summary>
    /// FindLastLogInserted.
    /// </summary>
    /// <param name="Customer No.">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure FindLastLogInserted("Customer No.": Code[20]): Text
    var
        BETCLECustomerLogEntry: Record "BET CLE Customer Log Entry";
        DateTxt, TimeTxt : Text;
        DateTimeTok: Label '%1-%2', Comment = '%1 is Date in datatype of text, %2 is Time in datatype of text';
        NoEntriesErr: Label 'There are no customer log entries for customer number: %1', Comment = '%1 is Customer No.';
    begin
        BETCLECustomerLogEntry.SetRange("Customer No.", "Customer No.");
        BETCLECustomerLogEntry.SetRange("Operation Type", Enum::"BET CLE Operation Type"::Insert);
        if not BETCLECustomerLogEntry.FindLast() then
            Exit(StrSubstNo(NoEntriesErr, "Customer No."));

        DateTxt := Format(BETCLECustomerLogEntry."Date of Modification", 0, '<Day,2>/<Month,2>/<Year4>');
        TimeTxt := Format(BETCLECustomerLogEntry."Time of Modification", 0, '<Hours24,2>:<Minutes,2>');

        Exit(StrSubstNo(DateTimeTok, DateTxt, TimeTxt));
    end;

    local procedure InitEntryDateAndTime(var BETCLECustomerLogEntry: Record "BET CLE Customer Log Entry")
    begin
        BETCLECustomerLogEntry."Date of Modification" := DT2Date(CurrentDateTime());
        BETCLECustomerLogEntry."Time of Modification" := DT2Time(CurrentDateTime());
    end;

    local procedure InitEntryNo(var BETCLECustomerLogEntry: Record "BET CLE Customer Log Entry")
    var
        LastOfBETCLECustomerLogEntry: Record "BET CLE Customer Log Entry";
    begin
        if not LastOfBETCLECustomerLogEntry.FindLast() then begin
            BETCLECustomerLogEntry."Entry No." := 1;
            Exit;
        end;

        BETCLECustomerLogEntry."Entry No." := LastOfBETCLECustomerLogEntry."Entry No." + 1;
    end;

    local procedure LogIfAddressChange(var Rec: Record Customer; var xRec: Record Customer)
    var
        ChangeFieldTxt: Label 'Changed Field: Address';
    begin
        if (Rec.Address <> xRec.Address) or (xRec.Address = '') then
            InsertCustomerLogEntry(Rec."No.", ChangeFieldTxt, Page::"Customer Card", Enum::"BET CLE Operation Type"::Modify);
    end;

    local procedure LogCustomerNameAndNoActions(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header")
    var
        DescriptionInsertTok: Label 'Customer No. %1 is entered on Document No. %2', Comment = '%1 is Customer No. , %2 is Document No.';
        DescriptionDeleteTok: Label 'Customer No. %1 is removed from Document No. %2', Comment = '%1 is Customer No. , %2 is Document No.';
        InsertTxt: Text[100];
        DeleteTxt: Text[100];
        SourcePage: Integer;
    begin
        InsertTxt := StrSubstNo(DescriptionInsertTok, SalesHeader."Sell-to Customer No.", SalesHeader."No.");
        GetSourcePageId(SalesHeader, SourcePage);
        InsertCustomerLogEntry(SalesHeader."Sell-to Customer No.", InsertTxt, SourcePage, Enum::"BET CLE Operation Type"::Insert);

        if SalesHeader."Sell-to Customer No." <> xSalesHeader."Sell-to Contact No." then begin
            DeleteTxt := StrSubstNo(DescriptionDeleteTok, xSalesHeader."Sell-to Customer No.", xSalesHeader."No.");
            InsertCustomerLogEntry(xSalesHeader."Sell-to Customer No.", DeleteTxt, SourcePage, Enum::"BET CLE Operation Type"::Delete);
        end;
    end;

    local procedure GetSourcePageId(var SalesHeader: Record "Sales Header"; var SourcePage: Integer)
    begin
        case SalesHeader."Document Type" of
            Enum::"Sales Document Type"::"Credit Memo":
                SourcePage := Page::"Sales Credit Memo";
            Enum::"Sales Document Type"::Invoice:
                SourcePage := Page::"Sales Invoice";
            Enum::"Sales Document Type"::Order:
                SourcePage := Page::"Sales Order";
            Enum::"Sales Document Type"::Quote:
                SourcePage := Page::"Sales Quote";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteCustomerLogEntry_OnAfterDeleteEvent(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        DeleteCustomerLogEntry(Rec."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterOnInsert', '', false, false)]
    local procedure InsertCustomerLogEntry_OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    begin
        InsertCustomerLogEntry(Customer."No.", 'Customer Created', Page::"Customer Card", Enum::"BET CLE Operation Type"::Insert);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure InsertCustomerLogEntry_OnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    begin
        LogIfAddressChange(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSelltoCustomerNoOnAfterValidate', '', false, false)]
    local procedure InsertCustomerLogEntry_OnAfterSelltoCustomerNoOnAfterValidate(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header")
    begin
        LogCustomerNameAndNoActions(SalesHeader, xSalesHeader);
    end;

    // Debug, može raditi na predvidljiviji način
    /*
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure InsertCustomerLogEntry_OnAfterValidateEvent(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        Message('%1', CurrFieldNo);
    end;
    */
}