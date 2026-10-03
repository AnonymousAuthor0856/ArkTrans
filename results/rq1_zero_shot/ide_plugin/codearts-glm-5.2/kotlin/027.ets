const AppColors = {
  primary: '#A0C4FF',
  secondary: '#B7E4C7',
  tertiary: '#FFDDC1',
  background: '#F8F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F0F5',
  outline: '#D9D9E3',
  success: '#B4E4C7',
  warning: '#FFDDC1',
  error: '#FFB4AB',
  onPrimary: '#001D3D',
  onSecondary: '#003720',
  onTertiary: '#3E2800',
  onBackground: '#1B1B1F',
  onSurface: '#1B1B1F'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      Row() {
        Column()
          .width(24)
          .height(24)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .margin({ left: AppSpacing.md })

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(4)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: 6, bottom: 6 })
          .margin({ right: AppSpacing.md })
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Center)

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Text(`${page}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
                .width('100%')
                .aspectRatio(0.7)
                .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
                .border(this.selectedPage === page ? { width: 2, color: AppColors.primary, radius: 8 } : { width: 0, color: AppColors.outline, radius: 8 })
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedPage = page
                })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)
        .width(150)
        .height('100%')
        .padding(AppSpacing.sm)

        Stack() {
          Text(`Page ${this.selectedPage}`)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Column({ space: AppSpacing.sm }) {
            Text('P')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedTool === 'pen' ? AppColors.onSecondary : AppColors.onSurface)
              .width(40)
              .height(40)
              .backgroundColor(this.selectedTool === 'pen' ? AppColors.secondary : AppColors.surfaceVariant)
              .borderRadius(20)
              .textAlign(TextAlign.Center)
              .onClick(() => { this.selectedTool = 'pen' })
            Text('H')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedTool === 'highlighter' ? AppColors.onSecondary : AppColors.onSurface)
              .width(40)
              .height(40)
              .backgroundColor(this.selectedTool === 'highlighter' ? AppColors.secondary : AppColors.surfaceVariant)
              .borderRadius(20)
              .textAlign(TextAlign.Center)
              .onClick(() => { this.selectedTool = 'highlighter' })
            Text('T')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedTool === 'text' ? AppColors.onSecondary : AppColors.onSurface)
              .width(40)
              .height(40)
              .backgroundColor(this.selectedTool === 'text' ? AppColors.secondary : AppColors.surfaceVariant)
              .borderRadius(20)
              .textAlign(TextAlign.Center)
              .onClick(() => { this.selectedTool = 'text' })
            Text('S')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.selectedTool === 'shape' ? AppColors.onSecondary : AppColors.onSurface)
              .width(40)
              .height(40)
              .backgroundColor(this.selectedTool === 'shape' ? AppColors.secondary : AppColors.surfaceVariant)
              .borderRadius(20)
              .textAlign(TextAlign.Center)
              .onClick(() => { this.selectedTool = 'shape' })
          }
          .padding(AppSpacing.sm)
          .backgroundColor('#CCFFFFFF')
          .border({ width: 1, color: AppColors.outline, radius: 12 })
          .margin({ left: AppSpacing.md })
          .align(Alignment.Start)
        }
        .layoutWeight(1)
        .height('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(12)
        .margin({ left: AppSpacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}