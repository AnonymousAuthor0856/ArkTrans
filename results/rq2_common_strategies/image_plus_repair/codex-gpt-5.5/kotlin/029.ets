interface FileItem {
  name: string
  type: string
  size: string
}

interface AppColors {
  background: string
  surface: string
  surfaceVariant: string
  primary: string
  tertiary: string
  outline: string
}

const COLORS: AppColors = {
  background: '#FFFFFF',
  surface: '#F9F9F9',
  surfaceVariant: '#EAEAEA',
  primary: '#111111',
  tertiary: '#555555',
  outline: '#D0D0D0'
}

@Entry
@Component
struct MainPage {
  private readonly files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  build() {
    Column() {
      Text('File Manager')
        .width('100%')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.primary)
        .textAlign(TextAlign.Center)
        .margin({ top: 34, bottom: 68 })

      Column() {
        Text('Recent Files')
          .width('100%')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.primary)
          .margin({ bottom: 34 })

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.fileCard(file)
            }
          }, (file: FileItem) => file.name)
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(22)
        .rowsGap(24)
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 32, right: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  fileCard(file: FileItem) {
    Column() {
      Text(file.type)
        .width('100%')
        .height(120)
        .fontSize(28)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLORS.primary)
        .textAlign(TextAlign.Center)
        .textVerticalAlign(TextVerticalAlign.CENTER)
        .backgroundColor(COLORS.surfaceVariant)
        .borderRadius(18)

      Column() {
        Text(file.name)
          .width('100%')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Clip })

        Text(file.size)
          .width('100%')
          .fontSize(25)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.tertiary)
          .margin({ top: 2 })
      }
      .width('100%')
      .margin({ top: 8 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(240)
    .padding({ left: 24, right: 24, top: 24, bottom: 20 })
    .backgroundColor(COLORS.surface)
    .borderRadius(28)
    .border({
      width: 1,
      color: '#E4E4E4',
      style: BorderStyle.Solid
    })
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 3
    })
  }
}
