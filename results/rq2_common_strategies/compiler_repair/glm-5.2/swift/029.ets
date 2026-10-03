// AppTokens - 集中管理应用程序的颜色、字体、形状、间距和阴影定义
interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyTokenType {
  size: number;
  weight: FontWeight;
}

interface TypographyTokensType {
  display: TypographyTokenType;
  title: TypographyTokenType;
  body: TypographyTokenType;
  label: TypographyTokenType;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  totalAppBarHeight: number;
}

interface ShadowSpecType {
  radius: number;
  dy: number;
  opacity: number;
  color: string;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
  level2: ShadowSpecType;
}

class AppTokens {
  static readonly Colors: ColorsType = {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#555555',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#EAEAEA',
    outline: '#D0D0D0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#111111',
    onSurface: '#111111'
  }

  static readonly TypographyTokens: TypographyTokensType = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapesType = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing: SpacingType = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    totalAppBarHeight: 100
  }

  static readonly ElevationMapping: ElevationMappingType = {
    level1: { radius: 4, dy: 2, opacity: 0.12, color: '#000000' },
    level2: { radius: 8, dy: 4, opacity: 0.16, color: '#000000' }
  }
}

// Data Model
interface FileItem {
  id: string;
  name: string;
  type: string;
  size: string;
}

// Components
@Component
struct BoxView {
  @Prop text: string;

  build() {
    Text(this.text)
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding(AppTokens.Spacing.sm)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
  }
}

@Component
struct FileCard {
  @Prop file: FileItem;

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column() {
        Text(this.file.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: 2 })

        Text(this.file.size)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .height(120)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { id: '1', name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { id: '2', name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { id: '3', name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { id: '4', name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { id: '5', name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ];

  build() {
    Column() {
      // Top App Bar
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)

        Text('File Manager')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(AppTokens.Spacing.totalAppBarHeight)

      // Main Content Area
      Column() {
        Text('Recent Files')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.lg })

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(0)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}