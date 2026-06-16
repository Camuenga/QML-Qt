// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls

Window {

    // TODO: change the size to ensure it forms the standard business card ratio of approx 1:1.586
    // HINT: you may wish to use a binding

    width: 500
    height: 793
    visible: true
    title: qsTr("Business Card")

    component ContactInfo: QtObject {

        // This is a ContactInfo object which provides the properties to fill in.
        // You can create as many instances of this as you like with different property values.

        property bool onState: false
        // show these properties all the time:
        property string name
        property url photo

        // Basic Info properties:
        property string occupation
        property string company

        // Detailed Info properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }


    ContactInfo {
        id: myContactInfo

        // this is one example instance of a ContactInfo inline Component
        // showing how the properties are populated.

        name: "Your Name"
        photo: Qt.resolvedUrl("IDPhoto.png")
        occupation: "QML Enthusiast"
        company: "Indie Soft"
        address: "Candy Cane Lane"
        country: "North Pole"
        phone: "+01 2345 567 890"
        email: "email@server.com"
        webSite: Qt.url("https://www.qt.io")
    }

    Rectangle{
        id: rectangleFather
        anchors.left: parent
        width: parent.width * 0.5
        height: parent.height * 0.5
        border.color: "black"
        Rectangle{
            id:texArea
            anchors.left: rectangleFather.left
            anchors.top: rectangleFather.top
            anchors.margins: 8
            width: parent.width * 0.5
            height: 150
            color:"blue"
            Text {
                id:name
                text: qsTr(myContactInfo.name)
                font.pixelSize: 50
                font.bold: true
            }
            Text {
                id:occupation
                anchors.top: name.bottom
                anchors.topMargin: 5
                text: qsTr(myContactInfo.occupation)
                font.pixelSize: 30
            }
            Text {
                anchors.top: occupation.bottom
                anchors.topMargin: 5
                text: qsTr(myContactInfo.company)
                font.pixelSize: 30
            }
//------------------------------------------------------------
        }
        Component{
            id: infoComponent

            Rectangle{
                id:profileInfo
                anchors.bottom: rectangleFather.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 160
                width: rectangleFather.width * 0.5
                height: 170
                color:"green"
                Text {
                    id:address
                    text: qsTr(myContactInfo.address)
                    font.pixelSize: 20
                }
                Text {
                    id:country
                    anchors.top: address.bottom
                    anchors.topMargin: 5
                    text: qsTr(myContactInfo.country)
                    font.pixelSize: 20
                }
                Text {
                    id:phone
                    anchors.top: country.bottom
                    anchors.topMargin: 5
                    text: qsTr(myContactInfo.phone)
                    font.pixelSize: 20
                }
                Text {
                    id:email
                    anchors.top: phone.bottom
                    anchors.topMargin: 5
                    text: qsTr(myContactInfo.email)
                    font.pixelSize: 20
                }
                Text {
                    anchors.top: email.bottom
                    anchors.topMargin: 5
                    text: qsTr(myContactInfo.webSite.toString())
                    font.pixelSize: 20
                }
            }
        }
//-----------------------------------------------------------------------
        Loader{
            id:loaderinfo
        }

        Rectangle{
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            id: childRecangle
            width: 200
            height: 200
            border.color: "black"
            color:"red"
            Image {
                anchors.centerIn: parent
                width:150
                height:150
                source: myContactInfo.photo
            }
        }

        Button{
            id:button
            width:90
            height:35
            text:"Details"
            font.pixelSize: mouseArea.pressed ? 12 : 10
            anchors.bottom: rectangleFather.bottom
            anchors.left: rectangleFather.left
            anchors.margins: 10
            background: Rectangle{
                id:borderButton
                radius: 15
                border.color: "black"
                border.width: 1
                color: mouseArea.pressed ? "#00414a" : "#ffffff"
            }

            MouseArea{
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked:{
                    if(!myContactInfo.onState){
                        myContactInfo.onState = true;
                        loaderinfo.sourceComponent = infoComponent;
                    }else if(myContactInfo.onState){
                        loaderinfo.sourceComponent = undefined;
                        myContactInfo.onState = false;
                    }
                }
            }

        }
    }

}
