PROGRAM PrintHelloName(INPUT, OUTPUT);
USES
  DOS;
VAR
  Name: STRING;

FUNCTION GetQueryStringParameter(Key: STRING): STRING;
VAR
  QueryString, S: STRING;
  N: INTEGER;
BEGIN
  QueryString := GetEnv('QUERY_STRING');
  Insert('&', QueryString, 1);
  N := Pos(('&' + Key + '='), QueryString);
  IF N = 0
  THEN
    S := 'Parameter is missing'
  ELSE
    BEGIN
      S := Copy(QueryString, (N + 1), Length(QueryString));
      N := Pos('&', S);
      IF N = 0
      THEN
        S := Copy(S, (Length(Key) + 2), Length(S))
      ELSE
        S := Copy(S, (Length(Key) + 2), (N - Length(Key) - 2))
    END;
  GetQueryStringParameter := S
END;

BEGIN
  WRITELN('Content-Type: text/plain');
  WRITELN;
  Name := GetQueryStringParameter('name');
  IF Name = 'Parameter is missing'
  THEN
    WRITELN('Hello Anonymous!')
  ELSE
    WRITELN('Hello, dear ', Name)
END.
