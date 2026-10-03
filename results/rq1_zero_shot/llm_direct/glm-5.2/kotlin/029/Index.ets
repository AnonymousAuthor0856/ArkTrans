// AppTokens.ets
export class AppTokens {
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
  };

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
  };
}

interface FileItem {
  name: string;
  type: string;
  size: string;
}

@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { name: "Report.pdf", type: "PDF", size: "2.1 MB" },
    { name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB" },
    { name: "Design.psd", type: "Image", size: "4.7 MB" },
    { name: "Presentation.pptx", type: "Slides", size: "5.4 MB" },
    { name: "MeetingNotes.txt", type: "Text", size: "64 KB" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("File Manager")
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);

      // Content Area
      Column() {
        Text("Recent Files")
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.lg });

        // Grid
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              // Card
              Column() {
                // File Type Box
                Row() {
                  Text(file.type)
                    .fontSize(AppTokens.Typography.body.fontSize)
                    .fontWeight(AppTokens.Typography.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .width('100%')
                .height(60)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center);

                // File Info
                Column() {
                  Text(file.name)
                    .fontSize(AppTokens.Typography.title.fontSize)
                    .fontWeight(AppTokens.Typography.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .margin({ bottom: 2 });

                  Text(file.size)
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(AppTokens.Colors.tertiary);
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ top: AppTokens.Spacing.md });
              }
              .width('100%')
              .height(120)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .justifyContent(FlexAlign.SpaceBetween)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              });
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.md)
        .columnsGap(AppTokens.Spacing.md)
        .layoutWeight(1)
        .width('100%');
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}