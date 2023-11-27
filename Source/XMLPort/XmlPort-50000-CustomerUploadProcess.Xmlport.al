xmlport 50000 "Import Customer"
{
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(CustomerImport; Integer)
            {
                AutoSave = false;
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textelement(Name)
                {
                    MinOccurs = Zero;
                }
                textelement(PrintName)
                {
                    MinOccurs = Zero;
                }
                textelement(Address)
                {
                    MinOccurs = Zero;
                }
                textelement(Address2)
                {
                    MinOccurs = Zero;
                }
                textelement(Address3)
                {
                    MinOccurs = Zero;
                }
                textelement(StateCode)
                {
                    MinOccurs = Zero;
                }
                textelement(Postcode)
                {
                    MinOccurs = Zero;
                }
                textelement(PhnoeNo)
                {
                    MinOccurs = Zero;
                }
                textelement(FaxNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Emailid)
                {
                    MinOccurs = Zero;
                }
                textelement(Homepage)
                {
                    MinOccurs = Zero;
                }
                textelement(GeneralBusinPsGrp)
                {
                    MinOccurs = Zero;
                }
                textelement(CustomerPostingGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(CustomerPriceGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(ApplicationMethod)
                {
                    MinOccurs = Zero;
                }
                textelement(PaymentTermsCode)
                {
                    MinOccurs = Zero;
                }
                textelement(CurrencyCode)
                {
                    MinOccurs = Zero;
                }
                textelement(GSTRegistrationNo)
                {
                    MinOccurs = Zero;
                }
                textelement(GSTCustomerType)
                {
                    MinOccurs = Zero;
                }
                textelement(PANNo)
                {
                    MinOccurs = Zero;
                }
                textelement(PANStatus)
                {
                    MinOccurs = Zero;
                }
                textelement(QualityProcess)
                {
                    MinOccurs = Zero;
                }
                textelement(AuthrizePerson)
                {
                    MinOccurs = Zero;
                }
                textelement(RSMName)
                {
                    MinOccurs = Zero;
                }
                textelement(SecurityChequeNo)
                {
                    MinOccurs = Zero;
                }
                textelement(MSMENo)
                {
                    MinOccurs = Zero;
                }
                textelement(FASSAINo)
                {
                    MinOccurs = Zero;
                }
                textelement(SKipTcs)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin
                    IF SKipFirstRow THEN begin
                        SKipFirstRow := FALSE;
                        currXMLport.SKIP;
                    end
                end;

                trigger OnBeforeInsertRecord()
                var
                    SalesRecivalbeSetup: Record "Sales & Receivables Setup";
                    CustomerNo: Code[20];
                    NoSeriesmMang: Codeunit NoSeriesManagement;
                    CustomerImport: Record Customer;
                    ImportCustomer: Record Customer;
                begin
                    SalesRecivalbeSetup.GET;
                    CustomerNo := NoSeriesmMang.GetNextNo(SalesRecivalbeSetup."Customer Nos.", TODAY, TRUE);
                    if not CustomerImport.get(CustomerNo) then begin
                        ImportCustomer.Init();
                        ImportCustomer."No." := CustomerNo;
                        ImportCustomer.Validate(Name, Name);
                        ImportCustomer.Validate("Print Name", PrintName);
                        ImportCustomer.Validate(Address, Address);
                        ImportCustomer.Validate("Address 2", Address2);
                        ImportCustomer.Validate("Address 3", Address3);
                        ImportCustomer.Validate("State Code", StateCode);
                        ImportCustomer.Validate("Post Code", Postcode);
                        ImportCustomer.Validate("Phone No.", PhnoeNo);
                        ImportCustomer.Validate("Fax No.", FaxNo);
                        ImportCustomer.Validate("E-Mail", Emailid);
                        ImportCustomer.Validate("Home Page", Homepage);
                        ImportCustomer.Validate("Gen. Bus. Posting Group", GeneralBusinPsGrp);
                        ImportCustomer.Validate("Customer Posting Group", CustomerPostingGroup);
                        ImportCustomer.Validate("Customer Price Group", CustomerPriceGroup);
                        if ApplicationMethod = 'Manual' then
                            ImportCustomer.Validate("Application Method", ImportCustomer."Application Method"::Manual)
                        else
                            ImportCustomer.Validate("Application Method", ImportCustomer."Application Method"::"Apply to Oldest");
                        ImportCustomer.Validate("Payment Terms Code", PaymentTermsCode);
                        ImportCustomer.Validate("Currency Code", CurrencyCode);

                        ImportCustomer.Validate("GST Registration No.", GSTRegistrationNo);
                        if GSTCustomerType <> '' then begin
                            Evaluate(GSTCustomType, GSTCustomerType);
                            ImportCustomer.Validate("GST Customer Type", GSTCustomType);
                        end;
                        ImportCustomer.Validate("P.A.N. No.", PANNo);
                        if PANStatus <> '' then begin
                            Evaluate(PAN_Status, PANStatus);
                            ImportCustomer.Validate("P.A.N. Status", PAN_Status);
                        end;
                        ImportCustomer.Validate("Quality Process", QualityProcess);
                        ImportCustomer.Validate("Authorized person", AuthrizePerson);
                        ImportCustomer.Validate("RSM Name", RSMName);
                        ImportCustomer.Validate("Security Cheque No", SecurityChequeNo);
                        ImportCustomer.Validate("MSME No.", MSMENo);
                        ImportCustomer.Validate("FASSAI No.", FASSAINo);
                        if SKipTcs <> '' then begin
                            Evaluate(SkipTCSBo, SKipTcs);
                            ImportCustomer.Validate("Skip TCS", SkipTCSBo);
                        end;
                        ImportCustomer.Validate(Blocked, ImportCustomer.Blocked::All);
                        ImportCustomer.Insert();
                    end;
                end;
            }
        }
    }
    trigger OnInitXmlPort()
    var

    begin
        SkipFirstRow := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message('Import Successfully');
    end;

    var
        SkipFirstRow: Boolean;
        SkipTCSBo: Boolean;
        GSTCustomType: Enum "GST Customer Type";
        PAN_Status: Enum "P.A.N.Status";
}