//
// bpcbase.h: Defines the CBPCDeviceBase class 
//
// Copyright (C) 1997 Microsoft Corporation
// All rights reserved.
//
// This source code is only intended as a supplement to the
// Broadcast Architecture Programmer's Reference.
// For detailed information regarding Broadcast
// Architecture, see the reference.
//
#if !defined(AFX_BPCDEVICEBASE_H__4E088A12_0E75_11D1_A073_00A0C9054174__INCLUDED_)
#define AFX_BPCDEVICEBASE_H__4E088A12_0E75_11D1_A073_00A0C9054174__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// Machine generated IDispatch wrapper class(es) created by Microsoft Visual C++

// NOTE: Do not modify the contents of this file.  If this class is regenerated by
//  Microsoft Visual C++, your modifications will be overwritten.

/////////////////////////////////////////////////////////////////////////////
// CBPCDeviceBase wrapper class

class CBPCDeviceBase : public COleDispatchDriver
{
public:
	CBPCDeviceBase() {}		// Calls COleDispatchDriver default constructor
	CBPCDeviceBase(LPDISPATCH pDispatch) : COleDispatchDriver(pDispatch) {}
	CBPCDeviceBase(const CBPCDeviceBase& dispatchSrc) : COleDispatchDriver(dispatchSrc) {}

// Attributes
public:

// Operations
public:
	CString GetName();
	BOOL GetHasFilename();
	BOOL GetHasCA();
	BOOL GetIsInput();
	BOOL GetIsOutput();
	BOOL GetHasChannel();
	long GetStatus();
	CString GetProdName();
	CString GetFileName();
	void SetFileName(LPCTSTR lpszNewValue);
	long GetChannel();
	void SetChannel(long nNewValue);
	BOOL GetChannelAvailable(long nChannel);
	long GetImageSourceWidth();
	long GetImageSourceHeight();
	long GetCurrentState();
	double GetCurrentPosition();
	void SetCurrentPosition(double newValue);
	double GetDuration();
	double GetPrerollTime();
	void SetPrerollTime(double newValue);
	double GetRate();
	void SetRate(double newValue);
	long GetCountryCode();
	void SetCountryCode(long nNewValue);
	long GetVideoFrequency();
	long GetAudioFrequency();
	long GetDefaultVideoType();
	void SetDefaultVideoType(long nNewValue);
	long GetDefaultAudioType();
	void SetDefaultAudioType(long nNewValue);
	long GetVideoSubchannel();
	void SetVideoSubchannel(long nNewValue);
	long GetAudioSubchannel();
	void SetAudioSubchannel(long nNewValue);
	void SetVolume(long nNewValue);
	long GetVolume();
	void SetBalance(long nNewValue);
	long GetBalance();
	void SetPower(BOOL bNewValue);
	BOOL GetPower();
	void SetOverScan(long nNewValue);
	long GetOverScan();
	long GetProviderRating();
	BOOL GetProviderStatus();
	long GetProviderEPGMask();
	LPDISPATCH GetHistoryItems();
	LPDISPATCH GetEmailMessages();
	CString GetUserName_();
	void SetUserName(LPCTSTR lpszNewValue);
	CString GetUserArea();
	void SetUserArea(LPCTSTR lpszNewValue);
	LPDISPATCH GetItemDetails(long Priority, LPDISPATCH pInDetails);
	long Command(long nCommand);
	void Run();
	void Pause();
	void Stop();
	void Refresh();
	void ResetProviderSystem();
	LPDISPATCH BuyItem(long Priority, LPDISPATCH pInDetails);
	LPDISPATCH CancelItem(LPDISPATCH pInDetails);
	void DisplayConfigDialog();
	void HandleCardChaining(BOOL fOK);
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_BPCDEVICEBASE_H__4E088A12_0E75_11D1_A073_00A0C9054174__INCLUDED_)
