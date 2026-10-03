@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFF2E0')

      // Main content
      Column({ space: 16 }) {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3D2623')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order info card
        Column({ space: 10 }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3D2623')
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#FFB84D')
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress bar
          Stack({ alignContent: Alignment.Start }) {
            // Inactive track
            Row()
              .width('100%')
              .height(10)
              .borderRadius(5)
              .backgroundColor('#FFE0B2')

            // Active track
            Row()
              .width(`${this.progress * 100}%`)
              .height(10)
              .borderRadius(5)
              .backgroundColor('#FF7043')
          }
          .width('100%')
          .height(10)

          // Progress text row
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFB84D')

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF7043')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .padding(16)
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.15)',
          offsetX: 0,
          offsetY: 4
        })

        // Adjust progress card
        Column({ space: 10 }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3D2623')
            .width('100%')
            .textAlign(TextAlign.Center)

          // Custom Slider
          CustomSliderComponent({
            value: $progress,
            activeColor: '#FF7043',
            inactiveColor: '#FFE0B2',
            thumbColor: '#FF7043'
          })

          // Mark as Delivered button
          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .width('100%')
            .height(44)
            .backgroundColor('#FF7043')
            .borderRadius(10)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .padding(16)
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.15)',
          offsetX: 0,
          offsetY: 4
        })
      }
      .padding(16)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CustomSliderComponent {
  @Link value: number
  activeColor: string = '#FF7043'
  inactiveColor: string = '#FFE0B2'
  thumbColor: string = '#FF7043'
  private trackHeight: number = 10
  private thumbDiameter: number = 24
  private sliderWidth: number = 0

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Inactive track
      Row()
        .width('100%')
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.inactiveColor)
        .margin({ top: (this.thumbDiameter - this.trackHeight) / 2 })

      // Active track
      Row()
        .width(`${this.value * 100}%`)
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.activeColor)
        .margin({ top: (this.thumbDiameter - this.trackHeight) / 2 })

      // Thumb
      Row()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .borderRadius(this.thumbDiameter / 2)
        .backgroundColor(this.thumbColor)
        .margin({ left: `calc(${this.value * 100}% - ${this.thumbDiameter / 2}px)` })
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((oldVal, newVal) => {
      this.sliderWidth = newVal.width as number
    })
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          if (this.sliderWidth > 0) {
            let x = event.offsetX
            let newVal = Math.min(Math.max(0, x / this.sliderWidth), 1)
            this.value = newVal
          }
        })
        .onActionUpdate((event: GestureEvent) => {
          if (this.sliderWidth > 0) {
            let x = event.offsetX
            let newVal = Math.min(Math.max(0, x / this.sliderWidth), 1)
            this.value = newVal
          }
        })
    )
  }
}