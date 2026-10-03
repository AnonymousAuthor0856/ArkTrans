interface FileItem {
  name: string
  type: string
  size: string
}

class AppTokens {
  static readonly primary: string = '#111111'
  static readonly tertiary: string = '#555555'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#F9F9F9'
  static readonly surfaceVariant: string = '#EAEAEA'
}

@Entry
@Component
struct FileManagerApp {
  private readonly files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  @Builder
  private fileCard(file: FileItem) {
    Column() {
      Text(file.type)
        .fontSize(14)
        .fontColor(AppTokens.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(28)
        .lineHeight(28)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(14)

      Blank()
        .layoutWeight(1)

      Column() {
        Text(file.name)
          .fontSize(18)
          .fontColor(AppTokens.primary)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Clip })
          .width('100%')
          .lineHeight(22)

        Text(file.size)
          .fontSize(12)
          .fontColor(AppTokens.tertiary)
          .width('100%')
          .lineHeight(18)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    .height(120)
    .width('100%')
    .backgroundColor(AppTokens.surface)
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontColor(AppTokens.primary)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(100)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.background)

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontColor(AppTokens.primary)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .lineHeight(24)

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.fileCard(file)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 16, right: 16, top: 16 })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}
