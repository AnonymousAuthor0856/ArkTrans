import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// MARK: - AppTokens
interface ColorTokens {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level2: ElevationLevel;
}

const AppTokens = {
  Colors: {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as ColorTokens,
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  } as ShapeTokens,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  } as SpacingTokens,
  ElevationMapping: {
    level2: { radius: 8, dy: 4, opacity: 0.16 }
  } as ElevationMapping
};

// MARK: - Data Models
interface KanbanColumn {
  id: number;
  title: string;
  tasks: string[];
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;

  columns: KanbanColumn[] = [
    { id: 1, title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { id: 2, title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { id: 3, title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  aboutToAppear() {
    // Requirement 2: Hide status bar for full-screen effect
    let context = getContext(this) as common.UIAbilityContext;
    window.getWindowManager().getDefaultWindow(context).then((windowClass: window.Window) => {
      windowClass.setWindowLayoutFullScreen(true);
    });
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Kanban Board')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .foregroundColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onSurface)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor(AppTokens.Colors.primary)
        }
        .width('100%')

        // Kanban Columns (Horizontal Scroll)
        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              CardView({ column: col })
                .width(220)
                .height('100%')
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .height('100%')
        .layoutWeight(1)

        // Task Completion Section
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Task Completion')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onSurface)
          
          // Linear Progress Indicator
          Row() {
            // Track
            Rect()
              .fill(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)
              .width('100%')
              .height(8)
            
            // Progress Fill
            Rect()
              .fill(AppTokens.Colors.primary)
              .borderRadius(4)
              .width('65%')
              .height(8)
          }
          .width('100%')
          .clip(true)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CardView {
  private column: KanbanColumn = {} as KanbanColumn;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .foregroundColor(AppTokens.Colors.primary)

      Column({ space: AppTokens.Spacing.sm }) {
        ForEach(this.column.tasks, (task: string) => {
          AssistChipView({ task: task })
        })
      }
      
      Blank()
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

@Component
struct AssistChipView {
  private task: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.task)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .foregroundColor(AppTokens.Colors.onSurface)
    }
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .onClick(() => {
      // Action placeholder
    })
  }
}