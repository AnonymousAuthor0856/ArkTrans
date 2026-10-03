import { BusinessError } from '@kit.BasicServicesKit';

// AppTokens.ets
export class AppTokens {
  static readonly Colors: Record<string, string> = {
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
  };

  static readonly TypographyTokens: Record<string, { size: number; weight: FontWeight }> = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    totalAppBarHeight: 100
  };

  static readonly ElevationMapping: Record<string, { elevation: number; radius: number; dy: number; opacity: number }> = {
    level1: {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.12
    },
    level2: {
      elevation: 4,
      radius: 8,
      dy: 4,
      opacity: 0.16
    }
  };
}

// FileItem.ets
export interface FileItem {
  id: string;
  name: string;
  type: string;
  size: string;
}

// BoxView.ets
@Component
export struct BoxView {
  private text: string = ''

  build() {
    Text(this.text)
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .foregroundColor(AppTokens.Colors.onSurface)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
  }
}

// FileCard.ets
@Component
export struct FileCard {
  @Prop file: FileItem = { id: '', name: '', type: '', size: '' }

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column() {
        Text(this.file.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .foregroundColor(AppTokens.Colors.onSurface)
        
        Text(this.file.size)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .foregroundColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .spacing(2)
    }
    .padding(AppTokens.Spacing.md)
    .height(120)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level1.opacity + ')',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { id: '1', name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { id: '2', name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { id: '3', name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { id: '4', name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { id: '5', name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  build() {
    Column() {
      // Custom Top App Bar
      Stack() {
        Text('File Manager')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .foregroundColor(AppTokens.Colors.onSurface)
      }
      .height(AppTokens.Spacing.totalAppBarHeight)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Column() {
        Text('Recent Files')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .foregroundColor(AppTokens.Colors.primary)

        GridContainer()
          .columnsTemplate('1fr 1fr')
          .gutters([AppTokens.Spacing.md, AppTokens.Spacing.md])
          .childLayout({ type: ChildType.Dynamic })
          .onChildLayout((index: number, childLayout: ChildLayout) => {
            childLayout.width = '50%'
            childLayout.height = 'auto'
          })
          .forEach((file: FileItem) => {
            FileCard({ file: file })
              .margin({ bottom: AppTokens.Spacing.md })
          }, this.files)
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .systemBarProperties({ safeArea: SafeArea.NONE })
  }
}