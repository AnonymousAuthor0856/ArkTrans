@Entry
@Component
struct TeaBrewingScreen {
  @State time: string = '02:00'

  build() {
    Column() {
      // Main Content Container
      Column() {
        .width('100%')
        .padding({ left: 24, right: 24 })

        // Header Section
        this.HeaderSection()

        // Spacer
        Blank().height(32)

        // Tea Selection Card
        this.TeaSelectionCard()

        // Spacer
        Blank().height(32)

        // Timer Visualization
        this.TimerDisplay()

        // Spacer
        Blank().height(40)

        // Action Buttons
        this.ControlButtons()

        // Spacer (Pushes content down)
        Blank().layoutWeight(1)

        // Preparation Steps
        this.PreparationSteps()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontColor('#888888')
          .fontSize(16)
        Text('Tea Master')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .fontSize(28)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Settings Icon Button
      Row() {
        Image($r('app.media.ic_settings')) // Placeholder for settings icon
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
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      // Abstract Tea Icon
      Row() {
        // Simulating the canvas drawing with a simple circle and line
        Circle({ width: '70%', height: '70%' })
          .stroke('#6D4C41')
          .strokeWidth(2)
        
        Line()
          .width(2)
          .height('40%')
          .backgroundColor('#6D4C41')
          .position({ x: '50%', y: '30%' })
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(16)

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
      .alignItems(HorizontalAlign.Start)

      // Heart Icon
      Image($r('app.media.ic_favorite')) // Placeholder for heart icon
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
  TimerDisplay() {
    Stack() {
      // Background Ring
      Circle({ width: '100%', height: '100%' })
        .stroke('#F5F5F5')
        .strokeWidth(12)

      // Progress Ring (Simulated with SVG or Path for precise arc)
      // Using a simplified path to mimic the 240 degree sweep
      Path() {
        let pathStr = `M 110 10 A 100 100 0 1 1 35 140` 
        // Note: In a real app, use a dynamic progress component or precise SVG path
        // This is a visual approximation of the brown arc
      }
      .width('100%')
      .height('100%')
      .fill('#6D4C41')
      .lineWidth(12)
      .lineCap(LineCap.Round)
      
      // Inner Content
      Column() {
        Text('Steeping')
          .fontColor('#888888')
          .fontSize(14)
          .letterSpacing(2)
        Text(this.time)
          .fontColor('#000000')
          .fontSize(56)
          .fontWeight(FontWeight.Light)
          .margin({ top: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  ControlButtons() {
    Row() {
      // Reset Button
      Row() {
        Image($r('app.media.ic_refresh')) // Placeholder
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
        Image($r('app.media.ic_play')) // Placeholder
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
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(24)

      // Add Note Button
      Row() {
        Image($r('app.media.ic_add')) // Placeholder
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
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontColor('#CCCCCC')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })

      this.StepItem(step: '1', text: 'Boil fresh water to 95°C')
      this.StepItem(step: '2', text: 'Add 1 tsp of loose leaf per cup')
      this.StepItem(step: '3', text: 'Pour water and wait for timer')
    }
    .width('100%')
  }

  @Builder
  StepItem(step: string, text: string) {
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
      Image($r('app.media.ic_check')) // Placeholder
        .width(16)
        .height(16)
        .fillColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    
    Divider()
      .color('#FAFAFA')
      .strokeWidth(1)
  }
}