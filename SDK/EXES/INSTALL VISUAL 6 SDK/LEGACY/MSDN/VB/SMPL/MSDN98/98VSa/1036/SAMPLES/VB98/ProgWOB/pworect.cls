VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Rectangle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
' >> L'affichage complet du module donne de meilleurs r�sultats. <<
'
' Stockage pour le num�ro ID de d�bogage.
Private mlngDebugID As Long
Implements IDebug

' L'objet Rectangle impl�mente deux interfaces;
'   il dispose �galement d'une propri�t� (Filled)
'   et d'une m�thode (TimeTest) sur sa propre
'   interface.

Implements IShape
Implements Polygon

' L'objet Polygon interne d�tient en g�n�ral
'   les donn�es et fait une partie du travail.
'   L'objet Rectangle garde des r�f�rences �
'   l'interface Polygon et IShape de l'objet
'   Polygon interne.
Private mpyg As Polygon
Private mish As IShape

' Stockage pour la propri�t� Color
'   (Impl�mentation de l'interface Polygon).
Private mrgbColor As Long

' Stockage pour la propri�t� Filled
'   (Sur l'interface par d�faut de l'objet Rectangle).
Private mblnFilled As Boolean

' -------------------------------------
' L'impl�mentation de l'objet Rectangle
' de l'interface IShape d�marre ici.

' La proc�dure IShape.DrawToPictureBox
' ------ ----------------   est appel�e
'   pour dessiner une forme; chaque
'   classe de la forme doit donc fournir
'   sa propre impl�mentation.
'
Private Sub IShape_DrawToPictureBox(ByVal pb As PictureBox)
    ' Au lieu de d�l�guer � l'interface IShape
    '   de l'objet Polygon interne, l'objet
    '   Rectangle exploite la pr�sence d'une
    '   commande de graphiques pour dessiner
    '   une bo�te en une op�ration au lieu de
    '   quatre (les cr�ations graphiques �tant
    '   probablement le type d'op�rations
    '   demandant le plus de temps).
    Dim sngX1 As Single, sngY1 As Single
    Dim sngX2 As Single, sngY2 As Single
    Call mpyg.GetPoint(0, sngX1, sngY1)
    Call mpyg.GetPoint(1, sngX2, sngY2)
    If mblnFilled Then
        pb.Line (sngX1, sngY1)-(sngX2, sngY2), mrgbColor, BF
    Else
        pb.Line (sngX1, sngY1)-(sngX2, sngY2), mrgbColor, B
    End If
End Sub

' La m�thode IShape.TimeTest est utilis�e
' ====== --------       pour afficher la
'   d�pr�ciation r�duite de performances
'   de l'appel d'une m�thode appel�e sur
'   une interface qui impl�mente plusieurs
'   classes, en opposition � l'appel
'   d'une m�thode semblable sur les interfaces
'   par d�faut des classes.
'
Private Sub IShape_TimeTest()
End Sub

' -------------------------------------
' L'impl�mentation de l'interface Polygon
'   d�marre ici.

' Polygon.Color - �tant donn� que l'objet
' ======= -----     Polygon interne n'est pas
'   utilis� pour dessiner l'objet Rectangle,
'   la propri�t� Color est totalement �cras�e.
'   Cela n'est pas requis; l'objet Rectangle
'   peut d�l�guer le stockage de la propri�t�
'   Color � l'objet Polygon interne (comme la
'   classe Triangle), en enregistrant le code
'   d'impl�mentation et l'espace de stockage.
'   La couleur peut ainsi �tre extraite de
'   l'objet Polygon interne une fois que le
'   dessin est r�alis�.
Private Property Get Polygon_Color() As Long
    Polygon_Color = mrgbColor
End Property
'
Private Property Let Polygon_Color(ByVal RHS As Long)
    If 0 <> (RHS And &HFF000000) Then
        Err.Raise vbObjectError + 2080, , _
            "Valeur de couleur non valide pour l'objet Polygon."
        Exit Property
    End If
    mrgbColor = RHS
End Property

' Polygon.TimeTest - L'objet Rectangle dispose
' ======= --------  de trois m�thodes TimeTest:
'   une sur l'interface IShape (pour afficher
'   le polymorphisme et les liaisons pr�coces),
'   une sur sa propre interface (pour afficher
'   les liaisons tardives) et celle-ci qui est
'   le r�sultat de l'impl�mentation de l'interface
'   Polygon par l'objet Rectangle; elle n'est pas
'   utilis�e du tout.
Private Sub Polygon_TimeTest()
End Sub

' Polygon.GetPoint
' ======= --------
'
Private Sub Polygon_GetPoint(ByVal intPoint As Integer, X As Single, Y As Single)
    ' D�l�gue � l'objet Polygon interne.
    Call mpyg.GetPoint(intPoint, X, Y)
End Sub

' Polygon.GetPointCount
' ======= -------------
'
Private Property Get Polygon_GetPointCount() As Integer
    ' Il n'y a pas de point lors de la
    '   d�l�gation � l'objet Polygon interne:
    '   l'objet Rectangle est toujours
    '   d�fini par deux points.
    Polygon_GetPointCount = 2
End Property

' Polygon.SetPoints - Lors de l'impl�mentation
' ======= ---------     de la m�thode SetPoints
'   de l'interface Polygon, l'objet Rectangle
'   ex�cute son propre code pour v�rifier que
'   le tableau d'entr�e contient uniquement
'   deux points (quatre Single), et d�l�gue
'   ensuite � l'objet Polygon interne.
Private Sub Polygon_SetPoints(asngPoints() As Single)
    Dim blnBadArray As Boolean
    On Error Resume Next
    ' S'assure que le tableau d'entr�e ne contient
    '   pas plus de quatre �l�ments. La m�thode
    '   SetPoint de l'objet Polygon v�rifie que
    '   le tableau commence � z�ro.
    If UBound(asngPoints) <> 3 Then blnBadArray = True
    ' Si une erreur s'est produite lors de l'appel
    '   de la fonction UBound, le tableau est rejet�.
    If Err.Number <> 0 Then blnBadArray = True
    If blnBadArray Then
        Err.Raise vbObjectError + 2083, , _
            "Un rectangle est sp�cifi� par un tableau de quatre nombres (gauche, haut, droite, bas) dans un tableau commen�ant � z�ro."
        Exit Sub
    End If
    ' D�l�gue � l'objet Polygon interne, qui
    '   effectue la validation du tableau
    '   et le stocke.
    Call mpyg.SetPoints(asngPoints)
End Sub

' --------------------------------------
' La propre interface (par d�faut) de
'   l'objet Rectangle d�marre ici.

' La m�thode TimeTest ne prend pas
' --------   d'arguments, et effectue
'   imm�diatement un renvoi. Elle montre
'   une liaison tardive, en opposition �
'   la liaison pr�coce fournie en appelant
'   la m�thode TimeTest sur l'interface
'   IShape.
Public Sub TimeTest()
End Sub

' La propri�t� Filled d�termine si un
' ------    rectangle est rempli lors
'   du dessin.
Public Property Get Filled() As Boolean
    Filled = mblnFilled
End Property
'
Public Property Let Filled(ByVal NewValue As Boolean)
    mblnFilled = NewValue
End Property

' --------------------------------------
' Les proc�dures priv�es de la classe
'   (proc�dures d'aide et d'�v�nement)
'   d�marrent ici.

Private Sub Class_Initialize()
    Dim asngPoints(0 To 3) As Single
    ' Code de d�bogage.
    mlngDebugID = DebugInit(Me)
    '
    ' Cr�e l'objet Polygon interne, et
    '   obtient une r�f�rence � son
    '   interface IShape.
    Set mpyg = New Polygon
    Set mish = mpyg
    ' Initialise l'objet Polygon interne.
    Call mpyg.SetPoints(asngPoints)
End Sub

Private Sub Class_Terminate()
    DebugTerm Me
End Sub

' -------- Impl�mentation de IDebug --------
'
' IDebug.DebugID permet de distinguer
' ====== -------    les diff�rents objets. Il
'   est requis par les proc�dures de d�bogage
'   DebugInit, DebugTerm et DebugShow
'   d�clar�es dans le module modFriend.
'
Private Property Get IDebug_DebugID() As Long
    IDebug_DebugID = mlngDebugID
End Property

