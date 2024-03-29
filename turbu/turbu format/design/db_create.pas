unit db_create;

interface
uses
   Classes, ZLib, Windows;

procedure ExtractDB(filename: string);

implementation
uses
   turbu_database;

procedure ExtractDB(filename: string);
var
   resource: TResourceStream;
   decompressor: TDecompressionStream;
   outfile: TFileStream;
   size: integer;
begin
   resource := TResourceStream.Create(FindClassHInstance(TRpgDatabase), 'DB_TEMPLATE', RT_RCDATA);
   decompressor := TDecompressionStream.Create(resource);
   outfile := TFileStream.Create(filename, fmCreate);
   try
      decompressor.Read(size, sizeof(size));
      outfile.CopyFrom(decompressor, size);
   finally
      outFile.Free;
      decompressor.Free;
      resource.Free;
   end;
end;

end.
