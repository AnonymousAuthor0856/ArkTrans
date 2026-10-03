// Index.ets

class ShadowSpec {
  elevation: number = 0;
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppColors {
  primary: string = '#FFA0C4FF';
  secondary: string = '#FFB7E4C7';
  tertiary: string = '#FFFFDDC1';
  background: string = '#FFF8F7FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFF0F0F5';
  outline: string = '#FFD9D9E3';
  success: string = '#FFB4E4C7';
  warning: string = '#FFFFDDC1';
  error: string = '#FFFFB4AB';
  onPrimary: string = '#FF001D3D';
  onSecondary: string = '#FF003720';
  onTertiary: string = '#FF3E2800';
  onBackground: string = '#FF1B1B1F';
  onSurface: string = '#FF1B1B1F';
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class AppElevationMapping {
  level1: ShadowSpec = new ShadowSpec(1, 2, 1, 0.08);
  level2: ShadowSpec = new ShadowSpec(3, 4, 2, 0.10);
  level3: ShadowSpec = new ShadowSpec(6, 8, 4, 0.12);
}

interface ToolItem {
  icon: string;
  toolName: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = Array.from({ length: 12 }, (_v: unknown, k: number) => k + 1);
  private tools: ToolItem[] = [
    { icon: 'P', toolName: 'pen' },
    { icon: 'H', toolName: 'highlighter' },
    { icon: 'T', toolName: 'text' },
    { icon: 'S', toolName: 'shape' }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppColors.surfaceVariant)
          .margin({ right: 16 });

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Button('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .height(32)
          .padding({ left: 12, right: 12 });
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor(AppColors.background);

      // Content
      Row() {
        // Page List
        Scroll() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                Column() {
                  Text(page.toString())
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface);
                }
                .width('100%')
                .aspectRatio(0.7)
                .borderRadius(8)
                .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
                .border(this.selectedPage === page ? { width: 2, color: AppColors.primary } : { width: 0 })
                .justifyContent(FlexAlign.Center)
                .onClick(() => {
                  this.selectedPage = page;
                });
              }
            }, (page: number) => page.toString());
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding(8);
        }
        .width(150)
        .height('100%')
        .scrollBar(BarState.Off);

        // Spacer
        Column().width(12).height('100%');

        // PDF Viewer Area
        Stack({ alignContent: Alignment.Center }) {
          // Page Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold);
          }
          .width('100%')
          .height('100%')
          .borderRadius(12)
          .backgroundColor(AppColors.surface)
          .shadow({ radius: 2, color: `rgba(0,0,0,${AppElevationMapping.level1.opacity})`, offsetX: 0, offsetY: 1 })
          .justifyContent(FlexAlign.Center);

          // Annotation Tools
          Column() {
            ForEach(this.tools, (tool: ToolItem) => {
              Button({ type: ButtonType.Circle }) {
                Text(tool.icon)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.selectedTool === tool.toolName ? AppColors.onSecondary : AppColors.onSurface);
              }
              .width(40)
              .height(40)
              .backgroundColor(this.selectedTool === tool.toolName ? AppColors.secondary : AppColors.surfaceVariant)
              .margin({ bottom: 8 })
              .onClick(() => {
                this.selectedTool = tool.toolName;
              });
            }, (tool: ToolItem) => tool.toolName);
          }
          .padding(8)
          .borderRadius(12)
          .backgroundColor('#CCFFFFFF')
          .border({ width: 1, color: AppColors.outline })
          .position({ x: 12, y: '50%' })
          .markAnchor({ x: 0, y: '50%' });
        }
        .layoutWeight(1)
        .height('100%');
      }
      .layoutWeight(1)
      .padding(12)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}