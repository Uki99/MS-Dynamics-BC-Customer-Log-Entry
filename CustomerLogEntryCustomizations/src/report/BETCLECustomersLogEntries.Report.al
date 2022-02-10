/// <summary>
/// Report BET CLE Customers Log Entries (ID 64851).
/// </summary>
report 64851 "BET CLE Customers Log Entries"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/report/reportayout/CustomersLogEntriesLayout.rdl';
    Caption = 'Customers Log Entries';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", Name;

            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(ReportHeaderCaption; ReportHeaderCaptionLbl)
            {
            }
            column(CurrPageNoCaption; CurrPageNoCaptionLbl)
            {
            }
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Name; Name)
            {
                IncludeCaption = true;
            }

            dataitem("BET CLE Customer Log Entry"; "BET CLE Customer Log Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Entry No.");

                column(Entry_No_; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(Source_Page; "Source Page")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Operation_Type; "Operation Type")
                {
                    IncludeCaption = true;
                }
                column(Date_of_Modification; "Date of Modification")
                {
                    IncludeCaption = true;
                }
                column(Time_of_Modification; "Time of Modification")
                {
                    IncludeCaption = true;
                }
                column(User_ID; "User ID")
                {
                    IncludeCaption = true;
                }
                column(Salespers__Purch__Code; "Salespers./Purch. Code")
                {
                    IncludeCaption = true;
                }
            }
        }
    }

    var
        ReportHeaderCaptionLbl: Label 'Customer Log Entries';
        CurrPageNoCaptionLbl: Label 'Page';
}