class AppTokens {
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF333333',
    tertiary: '#FF555555',
    background: '#FFFFFFFF',
    surface: '#FFF9F9F9',
    surfaceVariant: '#FFEAEAEA',
    outline: '#FFD0D0D0',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF111111',
    onSurface: '#FF111111'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    totalAppBarHeight: 100
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

class FileItem {
  name: string
  type: string
  size: string

  constructor(name: string, type: string, size: string) {
    this.name = name
    this.type = type
    this.size = size
  }
}

@Component
struct FileCard {
  @Prop name: string
  @Prop type: string
  @Prop size: string

  build() {
    Column() {
      Text(this.type)
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .borderRadius(10)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })

      Blank()

      Column() {
        Text(this.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .height(120)
    .borderRadius(14)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct FileManager {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ]

  build() {
    Column() {
      Stack() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(AppTokens.Spacing.totalAppBarHeight)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Row() {
          FileCard({ name: this.files[0].name, type: this.files[0].type, size: this.files[0].size })
            .layoutWeight(1)
            .margin({ right: 6 })
          FileCard({ name: this.files[1].name, type: this.files[1].type, size: this.files[1].size })
            .layoutWeight(1)
            .margin({ left: 6 })
        }
        .width('100%')
        .margin({ top: 16 })

        Row() {
          FileCard({ name: this.files[2].name, type: this.files[2].type, size: this.files[2].size })
            .layoutWeight(1)
            .margin({ right: 6 })
          FileCard({ name: this.files[3].name, type: this.files[3].type, size: this.files[3].size })
            .layoutWeight(1)
            .margin({ left: 6 })
        }
        .width('100%')
        .margin({ top: 12 })

        Row() {
          FileCard({ name: this.files[4].name, type: this.files[4].type, size: this.files[4].size })
            .layoutWeight(1)
            .margin({ right: 6 })
          Column()
            .layoutWeight(1)
            .margin({ left: 6 })
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}