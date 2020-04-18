import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About")
            }

            TextArea {
                readOnly: true
                width: parent.width
                text: qsTr("L. Ron Hubbard name generator creates name by following rules: "
                         + "Take the first character of first name, three first characters of second name "
                         + "and append the last name."
                         + "\n\n"
                         + "For example Lafayette Ronald Hubbard becomes L. Ron Hubbard"
                         + "\n\n"
                         + "Author: Arto Jalkanen (ajalkane@gmail.com)"
                         + "\n\n"
                         + "This software is public domain")
                wrapMode: Text.WordWrap
            }
        }
    }
}
