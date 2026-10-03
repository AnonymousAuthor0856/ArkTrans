const NAME: string = '028_PDFAnnotator_en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Soft Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#A0C4FF';
  static readonly secondary: string = '#B7E4C7';
  static readonly tertiary: string = '#FFDDC1';
  static readonly background: string = '#F8F7FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0F0F5';
  static readonly outline: string = '#D9D9E3';
  static readonly success: string = '#B4E4C7';
  static readonly warning: string = '#FFDDC1';
  static readonly error: string = '#FFB4AB';
  static readonly onPrimary: string = '#001D3D';
  static readonly onSecondary: string = '#003720';
  static readonly onTertiary: string = '#3E2800';
  static readonly onBackground: string = '#1B1B1F';
  static readonly onSurface: string = '#1B1B1F';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @Builder
  TopBar(): void {
    Row() {
      Circle().width(24).height(24).fill(AppColors.surfaceVariant);
      Blank();
      Text('Document.pdf')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Button('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  PageThumb(page: number): void {
    Stack() {
      Text(page.toString())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface);
    }
    .width('100%')
    .aspectRatio(0.7)
    .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
    .border({ width: this.selectedPage === page ? 2 : 0, color: AppColors.primary })
    .borderRadius(8)
    .alignContent(Alignment.Center)
    .onClick(() => {
      this.selectedPage = page;
    });
  }

  @Builder
  ToolButton(icon: string, toolName: string): void {
    Button(icon)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.selectedTool === toolName ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(20)
      .width(40)
      .height(40)
      .onClick(() => {
        this.selectedTool = toolName;
      });
  }

  @Builder
  ToolPalette(): void {
    Column({ space: AppSpacing.sm }) {
      this.ToolButton('P', 'pen');
      this.ToolButton('H', 'highlighter');
      this.ToolButton('T', 'text');
      this.ToolButton('S', 'shape');
    }
    .padding(AppSpacing.sm)
    .backgroundColor('#CCFFFFFF')
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12);
  }

  build() {
    Column() {
      this.TopBar();
      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              this.PageThumb(page);
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)
        .width(150)
        .height('100%')
        .padding(AppSpacing.sm);
        Blank().width(AppSpacing.md);
        Stack() {
          Stack() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface);
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(12)
          .shadow({ radius: 2, color: '#14000000', offsetY: 1 })
          .alignContent(Alignment.Center);
          this.ToolPalette();
        }
        .layoutWeight(1)
        .height('100%')
        .alignContent(Alignment.Start);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.md);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
