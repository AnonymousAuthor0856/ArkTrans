@Entry
@Component
struct NoteEditor {
  @State title: string = ''
  @State content: string = ''

  // Color Tokens matching the Kotlin source
  private readonly COLORS: Record<string, string> = {
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
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurface)
          .onClick(() => {
            // Handle back action
          })

        // Title
        Text('Edit Note')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLORS.onSurface)
          .margin({ left: 16 })

        Blank().layoutWeight(1)

        // Action Icons (Pin, Alarm, Label, More)
        // Using generic placeholder images for icons as specific assets aren't provided
        Image($r('app.media.ic_pin'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        Image($r('app.media.ic_alarm'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        Image($r('app.media.ic_label'))
          .width(24)
          .height(24)
          .fillColor(this.COLORS.onSurfaceVariant)
          .margin({ right: 16 })

        Image($r('app.media.ic_more_vert'))
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
          .margin({ top: 24, bottom: 12 })
          .onChange((value: string) => {
            this.title = value
          })

        // Content Input Field
        TextArea({ placeholder: 'Start writing...' })
          .placeholderColor(this.COLORS.onSurfaceVariant)
          .fontSize(15)
          .fontColor(this.COLORS.onSurface)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .layoutWeight(1)
          .onChange((value: string) => {
            this.content = value
          })
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