import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Define color tokens interface
interface ColorTokens {
  primary: string;
  onPrimary: string;
  primaryContainer: string;
  onPrimaryContainer: string;
  secondary: string;
  onSecondary: string;
  secondaryContainer: string;
  onSecondaryContainer: string;
  tertiary: string;
  onTertiary: string;
  tertiaryContainer: string;
  onTertiaryContainer: string;
  error: string;
  onError: string;
  errorContainer: string;
  onErrorContainer: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  onSurfaceVariant: string;
  outline: string;
  outlineVariant: string;
  surfaceContainer: string;
  surfaceContainerHigh: string;
  surfaceDim: string;
}

const COLORS: ColorTokens = {
  primary: '#1E6D3B',
  onPrimary: '#FFFFFF',
  primaryContainer: '#D7F5D9',
  onPrimaryContainer: '#00210A',
  secondary: '#516351',
  onSecondary: '#FFFFFF',
  secondaryContainer: '#D4E8D3',
  onSecondaryContainer: '#0F1F12',
  tertiary: '#3A656F',
  onTertiary: '#FFFFFF',
  tertiaryContainer: '#BDEAF6',
  onTertiaryContainer: '#001F26',
  error: '#BA1A1A',
  onError: '#FFFFFF',
  errorContainer: '#FFDAD6',
  onErrorContainer: '#410002',
  background: '#F8FBF1',
  onBackground: '#191D19',
  surface: '#F8FBF1',
  onSurface: '#191D19',
  surfaceVariant: '#DDE5DA',
  onSurfaceVariant: '#424940',
  outline: '#727970',
  outlineVariant: '#C1C9BE',
  surfaceContainer: '#ECF0E6',
  surfaceContainerHigh: '#E7EAE0',
  surfaceDim: '#D8DCD3'
};

// Define typography tokens interface
interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
  caption: TypographyToken;
}

const TYPOGRAPHY: TypographyTokens = {
  display: { fontSize: 28, fontWeight: FontWeight.Bold },
  headline: { fontSize: 22, fontWeight: FontWeight.Medium },
  title: { fontSize: 16, fontWeight: FontWeight.Medium },
  body: { fontSize: 15, fontWeight: FontWeight.Normal },
  label: { fontSize: 12, fontWeight: FontWeight.Medium },
  caption: { fontSize: 11, fontWeight: FontWeight.Normal }
};

// Define spacing tokens interface
interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const SPACING: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 36
};

@Entry
@Component
struct EditNotePage {
  @State title: string = 'Weekend shopping list';
  @State items: string[] = ['Milk', 'Eggs', 'Bread', 'Butter', 'Cheese'];
  @State showOverflowMenu: boolean = false;

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Back button
        Button() {
          Text('←')
            .fontSize(20)
            .fontColor(COLORS.onSurface)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          router.back();
        })

        // Title
        Text('Edit Note')
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .margin({ left: SPACING.sm })

        Flex().layoutWeight(1)

        // Action buttons
        Button() {
          Text('📌')
            .fontSize(20)
            .fontColor(COLORS.onSurfaceVariant)
        }
        .backgroundColor(Color.Transparent)

        Button() {
          Text('⏰')
            .fontSize(20)
            .fontColor(COLORS.onSurfaceVariant)
        }
        .backgroundColor(Color.Transparent)

        Button() {
          Text('🏷️')
            .fontSize(20)
            .fontColor(COLORS.onSurfaceVariant)
        }
        .backgroundColor(Color.Transparent)

        // Overflow menu button
        Button() {
          Text('⋮')
            .fontSize(20)
            .fontColor(COLORS.onSurface)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.showOverflowMenu = !this.showOverflowMenu;
        })
      }
      .width('100%')
      .padding(SPACING.lg)
      .backgroundColor(COLORS.surface)

      // Main content area
      Column() {
        // Title input field
        TextInput({ placeholder: 'Title' })
          .text(this.title)
          .fontColor(COLORS.onSurface)
          .placeholderColor(COLORS.onSurfaceVariant)
          .fontWeight(FontWeight.Medium)
          .fontSize(TYPOGRAPHY.headline.fontSize)
          .borderWidth(0)
          .backgroundColor(Color.Transparent)
          .onChange((value: string) => {
            this.title = value;
          })

        // Checklist items
        List() {
          ForEach(this.items, (item: string) => {
            ListItem() {
              Row() {
                // Checkbox
                Button() {
                  Text('☐')
                    .fontSize(20)
                    .fontColor(COLORS.onSurfaceVariant)
                }
                .backgroundColor(Color.Transparent)

                // Item text
                Text(item)
                  .fontColor(COLORS.onSurface)
                  .fontSize(TYPOGRAPHY.body.fontSize)
                  .margin({ left: SPACING.sm })
              }
              .width('100%')
              .padding({ top: SPACING.sm, bottom: SPACING.sm })
            }
          })
        }
        .layoutWeight(1)
        .divider({ strokeWidth: 1, color: COLORS.outlineVariant })
      }
      .padding({ left: SPACING.lg, right: SPACING.lg })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}