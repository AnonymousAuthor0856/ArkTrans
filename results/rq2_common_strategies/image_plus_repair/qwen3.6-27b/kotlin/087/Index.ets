@Entry
@Component
struct TeaBrewingScreen {
  @State time: string = '02:00'

  build() {
    Column() {
      // Main Content Container
      Column() {
        // Header Section
        this.buildHeader()

        // Spacer
        Blank().height(32)

        // Tea Selection Card
        this.buildTeaCard()

        // Spacer
        Blank().height(32)

        // Timer Visualization
        this.buildTimerDisplay()

        // Spacer
        Blank().height(40)

        // Control Buttons
        this.buildControlButtons()

        // Spacer (Pushes content down)
        Blank().layoutWeight(1)

        // Preparation Steps
        this.buildPreparationSteps()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  buildHeader() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontColor('#888888')
          .fontSize(16)
        Text('Tea Master')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .fontSize(28)
          .margin({ top: 4 })
      }

      Blank()

      // Settings Icon Button
      Row() {
        Image($r('app.media.settings')) // Placeholder for settings icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildTeaCard() {
    Row() {
      // Abstract Tea Icon
      Row() {
        // Simulating the canvas drawing with a simple circle and line
        Circle({ width: '70%', height: '70%' })
          .stroke('#6D4C41')
          .strokeWidth(2)
        
        Line({ start: { x: 30, y: 15 }, end: { x: 30, y: 45 } })
          .stroke('#6D4C41')
          .strokeWidth(2)
          .lineCap(LineCap.Round)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('Earl Grey Reserve')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .fontSize(18)
        Text('Black Tea • 95°C')
          .fontColor('#8D6E63')
          .fontSize(14)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      // Heart Icon
      Image($r('app.media.favorite')) // Placeholder for heart icon
        .width(24)
        .height(24)
        .fillColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .borderRadius(24)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  buildTimerDisplay() {
    Stack() {
      // Background Ring
      Circle({ width: '100%', height: '100%' })
        .stroke('#F5F5F5')
        .strokeWidth(12)

      // Progress Arc (Simulated using SVG path or Canvas logic, here simplified with CSS border trick or custom shape)
      // For precise arc in ArkTS without complex canvas, we use a rotated container with border-radius
      // This is a visual approximation of the 240 degree sweep
      Row() {
        Circle({ width: '100%', height: '100%' })
          .stroke('#6D4C41')
          .strokeWidth(12)
          .linearGradient({
            angle: 240,
            colors: [['#6D4C41', 0], ['#6D4C41', 0.66], ['transparent', 0.66]]
          })
          // Note: A true arc requires Path/Canvas in ArkTS. 
          // Using a mask or clip-path is often cleaner for static screenshots.
          // Here we rely on the visual similarity.
      }
      .width('100%')
      .height('100%')
      
      // Inner Content
      Column() {
        Text('Steeping')
          .fontColor('#888888')
          .fontSize(14)
          .letterSpacing(2)
        Text(this.time)
          .fontColor('#000000')
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .margin({ top: 8 })
      }
    }
    .width(220)
    .height(220)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildControlButtons() {
    Row() {
      // Reset Button
      Row() {
        Image($r('app.media.refresh'))
          .width(24)
          .height(24)
          .fillColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(24)

      // Start Button
      Row() {
        Image($r('app.media.play'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
        Text('Start')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 8 })
      }
      .height(60)
      .width(120)
      .borderRadius(30)
      .backgroundColor('#6D4C41')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(24)

      // Add Note Button
      Row() {
        Image($r('app.media.add'))
          .width(24)
          .height(24)
          .fillColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildPreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontColor('#CCCCCC')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })

      // Step Item 1
      this.buildStepItem('1', 'Boil fresh water to 95°C')
      
      // Divider
      Divider()
        .color('#FAFAFA')
        .margin({ top: 8, bottom: 8 })

      // Step Item 2
      this.buildStepItem('2', 'Add 1 tsp of loose leaf per cup')

      // Divider
      Divider()
        .color('#FAFAFA')
        .margin({ top: 8, bottom: 8 })

      // Step Item 3
      this.buildStepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
  }

  @Builder
  buildStepItem(step: string, text: string) {
    Row() {
      // Number Bubble
      Text(step)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .borderRadius(12)
        .backgroundColor('#F5F5F5')

      Blank().width(12)

      Text(text)
        .fontColor('#444444')
        .fontSize(16)
        .layoutWeight(1)

      // Check Icon
      Image($r('app.media.check'))
        .width(16)
        .height(16)
        .fillColor('#EEEEEE')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}