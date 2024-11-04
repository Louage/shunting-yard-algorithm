codeunit 53002 "PTE_Unit of Measure Mgt."
{


    internal procedure UpdateSurface(var ItemUnitOfMeasure: Record "Item Unit of Measure")
    begin
        ItemUnitOfMeasure."PTE_Volume Sq. M." := ItemUnitOfMeasure.Length * ItemUnitOfMeasure.Width / (1000 * 1000);
    end;

    internal procedure UpdateVolume(var ItemUnitOfMeasure: Record "Item Unit of Measure")
    begin
        ItemUnitOfMeasure."PTE_Volume Kub. M." := ItemUnitOfMeasure.Length * ItemUnitOfMeasure.Width * ItemUnitOfMeasure.Height / (1000 * 1000 * 1000);
    end;

}