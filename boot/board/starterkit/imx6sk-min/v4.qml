import QtQuick 2.0
import QtMultimedia 5.4

Item {
	Rectangle {
		width: parent.width/2
		height: parent.height/2
		anchors.left: parent.left
		anchors.top: parent.top

		MediaPlayer {
			id: player0
			source: "imxv4l2:///dev/video0"
			autoPlay: true
		}

		VideoOutput {
			source: player0
			fillMode: VideoOutput.Stretch
			anchors.fill: parent
		}
	}

	Rectangle {
		width: parent.width/2
		height: parent.height/2
		anchors.right: parent.right
		anchors.top: parent.top

		MediaPlayer {
			id: player1
			source: "imxv4l2:///dev/video1"
			autoPlay: true
		}

		VideoOutput {
			source: player1
			fillMode: VideoOutput.Stretch
			anchors.fill: parent
		}
	}

	Rectangle {
		width: parent.width/2
		height: parent.height/2
		anchors.left: parent.left
		anchors.bottom: parent.bottom

		MediaPlayer {
			id: player2
			source: "imxv4l2:///dev/video2"
			autoPlay: true
		}

		VideoOutput {
			source: player2
			fillMode: VideoOutput.Stretch
			anchors.fill: parent
		}
	}

	Rectangle {
		width: parent.width/2
		height: parent.height/2
		anchors.right: parent.right
		anchors.bottom: parent.bottom

		MediaPlayer {
			id: player3
			source: "imxv4l2:///dev/video3"
			autoPlay: true
		}

		VideoOutput {
			source: player3
			fillMode: VideoOutput.Stretch
			anchors.fill: parent
		}
	}
}
