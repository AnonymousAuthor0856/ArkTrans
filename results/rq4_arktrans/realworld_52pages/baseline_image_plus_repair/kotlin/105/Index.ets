@Entry
@Component
struct EditNoteScreen {
  // Color Tokens matching the Kotlin source
  private readonly COLORS: ColorConfig = {
    background: '#F8FBF1',
    surface: '#F8FBF1',
    onSurface: '#191D19',
    onSurfaceVariant: '#424940',
    primary: '#1E6D3B'
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Back Button
        Image($r('app.media.back_icon'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurface)
          .margin({ right: 16 })

        // Title
        Text('Edit Note')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLORS.onSurface)
          .layoutWeight(1)

        // Action Icons (Pin, Alarm, Label)
        // Using generic system icons to approximate the Material icons
        Image($r('app.media.add_icon')) 
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        Image($r('app.media.add_icon'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        Image($r('app.media.add_icon'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        // More Options (Vertical Dots)
        Image($r('app.media.add_icon'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.COLORS.surface)

      // Main Content Area
      Column() {
        // Title Input Field
        TextInput({ placeholder: 'Title' })
          .placeholderColor(this.COLORS.onSurfaceVariant)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.COLORS.onSurface)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .width('100%')
          .margin({ top: 24, bottom: 12 })

        // Content Input Field
        TextInput({ placeholder: 'Start writing...' })
          .placeholderColor(this.COLORS.onSurfaceVariant)
          .fontSize(15)
          .fontColor(this.COLORS.onSurface)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .width('100%')
          .type(InputType.Normal)
          .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.COLORS.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLORS.background)
  }
}

interface ColorConfig {
  background: string;
  surface: string;
  onSurface: string;
  onSurfaceVariant: string;
  primary: string;
}