import QtQuick
import QtQuick.Shapes
import qs

// Circular progress ring with an icon in the middle.
Item {
    id: ring

    property real value: 0 // 0..1
    property color color: Theme.blue
    property string icon: ""
    property real thickness: 2.5

    anchors.verticalCenter: parent?.verticalCenter
    implicitWidth: 24
    implicitHeight: 24

    Behavior on value {
        NumberAnimation {
            duration: Theme.animMed
            easing.type: Easing.OutCubic
        }
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        // Track
        ShapePath {
            strokeColor: Theme.alpha(ring.color, 0.2)
            strokeWidth: ring.thickness
            fillColor: "transparent"

            PathAngleArc {
                centerX: ring.width / 2
                centerY: ring.height / 2
                radiusX: (ring.width - ring.thickness) / 2
                radiusY: radiusX
                startAngle: 0
                sweepAngle: 360
            }
        }

        // Fill, clockwise from 12 o'clock
        ShapePath {
            strokeColor: ring.color
            strokeWidth: ring.thickness
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: ring.width / 2
                centerY: ring.height / 2
                radiusX: (ring.width - ring.thickness) / 2
                radiusY: radiusX
                startAngle: -90
                sweepAngle: 360 * Math.max(0.001, Math.min(1, ring.value))
            }
        }
    }

    Label {
        anchors.centerIn: parent
        text: ring.icon
        color: ring.color
        font.pixelSize: 11
    }
}
