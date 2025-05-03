function child=map_par(parent,child,pos1,pos2)
SInd=size(parent,2);
for j=pos1:pos2
    for l=1:SInd
        NewElement=true;
        for m=1:SInd
            NewElement=NewElement&(parent(l)~=child(m));
        end
        if (NewElement)
            child(j)=parent(l);
            break
        end
    end
end