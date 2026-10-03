import { display } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// AppTokens - Design tokens
class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#555555';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#EAEAEA';
  static readonly outline: string = '#D0D0D0';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#111111';
  static readonly onSurface: string = '#111111';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
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
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ];

  @Builder
  FileCard(file: FileItem) {
    Column() {
      Column() {
        Row() {
          Column() {
            Text(file.type)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(60)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')

        Column() {
          Text(file.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(file.size)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 8 })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.md)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(120)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Content
      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .margin({ bottom: AppSpacing.lg })

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.FileCard(file)
            }
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct MainPage {
  build() {
    RootScreen()
  }
}