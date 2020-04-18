import QtQuick 2.0
import Sailfish.Silica 1.0
import "elron-name-generator-library.js" as Elron

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    property var generating: false
    property var generatedName: null

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Elron Name Generator")
            }
            TextField {
                id: firstName
                placeholderText: qsTr("Enter first name")
                label: qsTr("First name")
                width: parent.width
                enabled: !generating
            }
            TextField {
                id: middleName
                placeholderText: qsTr("Enter middle name")
                label: qsTr("Middle name")
                width: parent.width
                enabled: !generating
            }
            TextField {
                id: lastName
                placeholderText: qsTr("Last name")
                label: qsTr("Last name")
                width: parent.width
                enabled: !generating
            }

            Button {
                text: qsTr("Generate name")
                onPressed: {
                    generating = true
                    generatedName = null
                    firstName.activeFocus
                    // Don't want keyboard to open again
                    this.forceActiveFocus()
                }
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: isValid() && !generating

                function isValid() {
                    return isNotEmpty(firstName.text) && isNotEmpty(middleName.text) && isNotEmpty(lastName.text)
                }

                function isNotEmpty(value) {
                    return value && value.trim()
                }
            }

            ProgressBar {
                indeterminate: true
                width: parent.width
                label: qsTr("Generating Hubbard name")
                visible: generating
                Timer {
                    id: generatorTimer
                    running: page.generating
                    repeat: true
                    interval: 5000
                    onTriggered: {
                        generatedName = Elron.generateElronHubbardName(firstName.text, middleName.text, lastName.text)
                        generating = false
                    }
                }
            }

            TextArea {
                visible: !generating && generatedName
                readOnly: true
                width: parent.width
                text: qsTr("Generated L. Ron Hubbard name is ") + generatedName
                wrapMode: Text.WordWrap
            }
        }
    }
}
