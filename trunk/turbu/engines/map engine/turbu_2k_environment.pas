unit turbu_2k_environment;

interface
uses
   Collections.Base,
   turbu_heroes, turbu_database;

type
   T2kEnvironment = class
   private
      FDatabase: TRpgDatabase;
      FHeroes: IList<TRpgHero>;
   public
      constructor Create(database: TRpgDatabase);
      destructor Destroy; override;

      property heroes: IList<TRpgHero> read FHeroes;
   end;

var
   GSwitches: TArray<boolean>;

implementation
uses
   Collections.Lists,
   turbu_characters;

type
   THeroList = class(TObjectList<TRpgHero>);

var
   GEnvironment: T2kEnvironment;

{ T2kEnvironment }

constructor T2kEnvironment.Create(database: TRpgDatabase);
var
   hero: THeroTemplate;
   list: THeroList;
begin
   assert(GEnvironment = nil);
   FDatabase := database;
   list := THeroList.Create;
   list.OwnsObjects := true;
   FHeroes := list;
   for hero in database.hero.Values do
      FHeroes.Add(TRpgHero.Create(hero));
   setLength(GSwitches, database.switch.count + 1);
end;

destructor T2kEnvironment.Destroy;
begin
   GEnvironment := nil;
   inherited Destroy;
end;

{initialization
finalization
   THeroList.CleanupTypes; }
end.