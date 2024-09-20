GO
USE SP_HR

GO
CREATE Table GeneralInformation
(
[Id] INT IDENTITY PRIMARY KEY,
[Label] NVARCHAR (255) NULL,
[Text] NVARCHAR (255) NULL
)

--INSERT INTO GeneralInformation VALUES (N'İş yeri (müəssisənin adı)' , N'"SOCAR PETROLEUM" QSC')                                                   
--INSERT INTO GeneralInformation VALUES (N'İş yeri ünvanı (şəhər və ya rayon)', N'Bakı şəhəri, Nizami rayonu')
--INSERT INTO GeneralInformation VALUES (N'İş yeri ünvanı (küçəsinin adı və məhəllə nömrəsi)', N'Babək prospekti, məhəllə 2269')
--INSERT INTO GeneralInformation VALUES (N'İş yeri ünvanı (bina nömrəsi, mənzil nömrəsi, poçt indeksi)', N'Bina 1, Poçt indeksi AZ1031')
--INSERT INTO GeneralInformation VALUES (N'İş telefon nömrəsi', '(012) 570 09 01')
--INSERT INTO GeneralInformation VALUES (N'Rəhbərin və ya əvəz edici şəxsin adı (hesabat başlığı üçün)', N'Bəhlul Abdurəhmanov')
--INSERT INTO GeneralInformation VALUES (N'Rəhbərin və ya əvəz edici şəxsin vəzifəsi (hesabat başlığı üçün)', N'İqtisadiyyat və uçot departamentinin rəisi')
--INSERT INTO GeneralInformation VALUES (N'Personal və əmək h. şöbəsinin rəisi - adı (hesabat imza hissəsi üçün)', N'Seyfəddin Quliyev')
--INSERT INTO GeneralInformation VALUES (N'Personal və əmək h. şöbəsinin rəisi - vəzifə (hesabat imza hissəsi üçün)', N'Əməyin təşkili və əmək haqqı şöbəsinin rəisi ') 
--INSERT INTO GeneralInformation VALUES (N'Kadrlar şöbəsinin rəisi - adı (hesabat imza hissəsi üçün)', NULL)
--INSERT INTO GeneralInformation VALUES (N'Kadrlar şöbəsinin rəisi - vəzifə (hesabat imza hissəsi üçün)', NULL)
--INSERT INTO GeneralInformation VALUES (N'Kadrlar şöbəsi üzrə mütəxəssis - adı (hesabat imza hissəsi üçün)',N'Sofiya Kazımova')
--INSERT INTO GeneralInformation VALUES (N'Kadrlar şöbəsi üzrə mütəxəssis - vəzifə (hesabat imza hissəsi üçün)',N'Kadrlar şöbəsi üzrə mütəxəssis')
--INSERT INTO GeneralInformation VALUES (N'Mühafizə bölməsinin rəisi - adı (hesabat imza hissəsi üçün)',N'Kamran Tağıyev')
--INSERT INTO GeneralInformation VALUES (N'Mühafizə bölməsinin rəisi - vəzifə (hesabat imza hissəsi üçün)',N'Mühafizə bölməsinin rəisi')

