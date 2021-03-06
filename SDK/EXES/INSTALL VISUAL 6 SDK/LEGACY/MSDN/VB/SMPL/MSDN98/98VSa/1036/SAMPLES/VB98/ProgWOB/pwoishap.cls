VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IShape"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Le module de classe IShape est une "classe
'   abstraite" d�finissant l'interface IShape.
'   En r�alit�, ce n'est pas tout � fait le
'   cas puisqu'une v�ritable classe abstraite
'   ne peut servir � cr�er des objets. Cette
'   classe, comme toute classe d�finie dans
'   Visual Basic, peut servir � la cr�ation
'   d'objets mais ces objets ne seront pas
'   tr�s utiles car il existe des membres
'   sans impl�mentation, comme une v�ritable
'   classe abstraite.

' La m�thode TimeTest ne prend pas d'arguments
' --------      et son impl�mentation est
'   toujours vide (elle n'ex�cute pas de code).
'   Elle a pour seul but de montrer les liaisons
'   tardives et pr�coces.
Public Sub TimeTest()
End Sub

Public Sub DrawToPictureBox(ByVal pb As PictureBox)
End Sub

