VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsMessageArrival"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private WithEvents MessageQueueEvents As MSMQEvent
Attribute MessageQueueEvents.VB_VarHelpID = -1


Sub Initialize(objMQ As MSMQQueue)
    'Cr�er un nouvel objet d'�v�nement (ceci semble �trange - on s'attendrait � ce que MSMQ le cr�e)
    Set MessageQueueEvents = New MSMQEvent
    
    'D�finir la notification d'�v�nement...
    objMQ.EnableNotification MessageQueueEvents
End Sub

Private Sub MessageQueueEvents_Arrived(ByVal Queue As Object, ByVal Cursor As Long)
'    Stop
    'Restocker la liste de messages
'    frmClaimProcessing.FillPendingMessagesList
End Sub

Private Sub MessageQueueEvents_ArrivedError(ByVal Queue As Object, ByVal ErrorCode As Long, ByVal Cursor As Long)
 '   Stop
End Sub