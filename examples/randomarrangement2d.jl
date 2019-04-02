using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using Plasm

V,EV = Lar.randomcuboids(10, .75)
V = Plasm.normalize(V,flag=true)
Plasm.view(Plasm.numbering(.05)((V,[[[k] for k=1:size(V,2)], EV])))


W = convert(Lar.Points, V')
cop_EV = Lar.coboundary_0(EV::Lar.Cells)
cop_EW = convert(Lar.ChainOp, cop_EV)
V, copEV, copFE = Lar.Arrangement.planar_arrangement(W::Lar.Points, cop_EW::Lar.ChainOp)

triangulated_faces = Lar.triangulate2D(V, [copEV, copFE])
V = convert(Lar.Points, V')
FVs = convert(Array{Lar.Cells}, triangulated_faces)
Plasm.viewlarcolor(V::Lar.Points, FVs::Array{Lar.Cells})

EVs = Lar.FV2EVs(copEV, copFE) # polygonal face fragments
Plasm.viewlarcolor(V::Lar.Points, EVs::Array{Lar.Cells})

model = V,EVs
Plasm.view(Plasm.lar_exploded(model)(1.2,1.2,1.2))
