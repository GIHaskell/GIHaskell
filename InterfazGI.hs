main :: IO ()
main=do
    putStrLn "usuario\n"
    usr<-getLine
    putStrLn (usr++"\n")
    
    putStrLn "password\n"
    pass<-getLine
    putStrLn (pass++"\n")
    
    --No hacer prints y comparar con la base de datos
    
    putStrLn "Seleccione el tipo de pieza deseado\n"
    putStrLn(printTypes ["halal", "donner", "lahmakum"] 1)
    --if type==1 then print"
   
    
    --principal:: IO ()
printTypes:: [String]->Int->String
printTypes (x:xs) n
    |(not (null xs))&&(n/=1)="()  "++x++"\n"++printTypes xs (n-1)
    |(not (null xs))&&(n==1)="(*) "++x++"\n"++printTypes xs (n-1)
    |otherwise="()  "++x
    
