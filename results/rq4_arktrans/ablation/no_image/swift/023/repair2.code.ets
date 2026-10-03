@Entry
@Component
struct Index {
  @State isRunning: boolean = false
  @State knobPosition: KnobPosition = { x: 140, y: 50 }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Blank().height(12)

        Row() {
          Text('Pomodoro Timer').fontColor('#1E1E1E').fontSize(30)
        }.backgroundColor('#FFFFFF').height(64).width('100%')

        Column() {
          Stack() {
            Circle()
              .shadow({ color: Color.Black.withAlpha(0.1), radius: 8, offsetX: 0, offsetY: 2 })
              .width(280)
              .height(280)
              .fill('#FDE2E4')

            Circle()
              .width(180)
              .height(180)
              .fill(Color('#B4E3D0').withAlpha(0.4))

            Circle()
              .gesture(
                DragGesture()
                  .onActionStart((event: GestureEvent) => {
                    this.updateKnobPosition(event)
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    this.updateKnobPosition(event)
                  })
              )
              .position({ x: this.knobPosition.x, y: this.knobPosition.y })
              .width(60)
              .height(60)
              .fill('#FF8FAB')
          }

          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontColor(this.isRunning ? '#4CAF50' : '#F44336')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Row({ space: 12 }) {
            Button() {
              Text('Start')
                .clipShape(Circle())
                .backgroundColor('#FF8FAB')
                .width(90)
                .height(90)
                .fontColor('#FFFFFF')
                .fontSize(14)
            }
            .onClick(() => {
              this.isRunning = true
            })
            .type(ButtonType.Capsule)

            Button() {
              Text('Stop')
                .clipShape(Circle())
                .backgroundColor('#FFD6A5')
                .width(90)
                .height(90)
                .fontColor('#1E1E1E')
                .fontSize(14)
            }
            .onClick(() => {
              this.isRunning = false
            })
            .type(ButtonType.Capsule)
          }

          Stack({ alignContent: Alignment.Start }) {
            Rect()
              .height(8)
              .fill('#FDE2E4')
              .width('100%')

            Rect()
              .width('40%')
              .height(8)
              .fill('#FF8FAB')
          }
          .padding({ left: 12, right: 12 })
        }
        .padding({ top: 12 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }

  private updateKnobPosition(event: GestureEvent): void {
    const center: Point = { x: 140, y: 140 }
    const vector: Point = {
      x: event.localX - center.x,
      y: event.localY - center.y
    }
    const distance = Math.sqrt(vector.x * vector.x + vector.y * vector.y)

    if (distance > 0) {
      const normalizedVector: Point = {
        x: vector.x / distance,
        y: vector.y / distance
      }

      // Keep knob on the track (radius = 90 for 180 diameter circle)
      const trackRadius = 90
      this.knobPosition = {
        x: center.x + normalizedVector.x * trackRadius,
        y: center.y + normalizedVector.y * trackRadius
      }
    }
  }
}

interface KnobPosition {
  x: number;
  y: number;
}

interface Point {
  x: number;
  y: number;
}