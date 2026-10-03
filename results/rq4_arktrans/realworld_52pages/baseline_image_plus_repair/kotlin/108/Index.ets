import { DatePicker, TimePicker } from '@kit.ArkUI';
import { Button, Text, Row, Column, Flex, FlexAlign, GridRow, GridCol, Divider, Image, TextAlign, Color, ButtonType } from '@kit.ArkUI';

interface Colors {
  primary: string;
  onPrimary: string;
  primaryContainer: string;
  onPrimaryContainer: string;
  secondary: string;
  secondaryContainer: string;
  error: string;
  onError: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  onSurfaceVariant: string;
  outline: string;
  outlineVariant: string;
}

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface Shapes {
  small: number;
  medium: number;
  large: number;
  extraLarge: number;
}

interface Spacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface AppTokensConfig {
  Colors: Colors;
  TypographyTokens: TypographyTokens;
  Shapes: Shapes;
  Spacing: Spacing;
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#1E6D3B',
    onPrimary: '#FFFFFF',
    primaryContainer: '#D7F5D9',
    onPrimaryContainer: '#00210A',
    secondary: '#516351',
    secondaryContainer: '#D4E8D3',
    error: '#BA1A1A',
    onError: '#FFFFFF',
    background: '#F8FBF1',
    onBackground: '#191D19',
    surface: '#F8FBF1',
    onSurface: '#191D19',
    surfaceVariant: '#DDE5DA',
    onSurfaceVariant: '#424940',
    outline: '#727970',
    outlineVariant: '#C1C9BE',
  },
  TypographyTokens: {
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16,
    extraLarge: 24,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  },
};

@Entry
@Component
struct NotificationDialogs {
  @State showDatePicker: boolean = true;
  @State showTimePicker: boolean = false;
  @State postponeDate: number = new Date().getTime();

  build() {
    Column() {
      if (this.showDatePicker) {
        this.DatePickerDialog();
      }
      if (this.showTimePicker) {
        this.TimePickerDialog();
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  DatePickerDialog() {
    Column() {
      // Header
      Row() {
        Text('Select date')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ left: AppTokens.Spacing.lg });
        
        Blank()
        
        Image($r('app.media.ic_edit')) // Placeholder for edit icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.lg });
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
      
      Divider()
        .color(AppTokens.Colors.outlineVariant)
        .strokeWidth(1)
      
      // Month/Year selector and navigation
      Row() {
        Text('August 2026')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .margin({ left: AppTokens.Spacing.lg });
        
        Image($r('app.media.ic_arrow_down')) // Placeholder for dropdown arrow
          .width(16)
          .height(16)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.xs });
        
        Blank()
        
        Image($r('app.media.ic_arrow_left')) // Placeholder for left arrow
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.sm });
        
        Image($r('app.media.ic_arrow_right')) // Placeholder for right arrow
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.lg });
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      
      // Day of week headers
      Row() {
        ForEach(['S', 'M', 'T', 'W', 'T', 'F', 'S'], (day: string) => {
          Text(day)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .textAlign(TextAlign.Center)
            .width(`${100 / 7}%`)
        })
      }
      .width('100%')
      .padding({ bottom: AppTokens.Spacing.sm })
      
      // Calendar grid
      GridRow() {
        // Week 1
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Text('1')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        
        // Week 2
        GridCol() {
          Text('2')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('3')
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .width(40)
            .height(40)
        }
        GridCol() {
          Text('4')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('5')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('6')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('7')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('8')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        
        // Week 3
        GridCol() {
          Text('9')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('10')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('11')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('12')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('13')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('14')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('15')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        
        // Week 4
        GridCol() {
          Text('16')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('17')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('18')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('19')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('20')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('21')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('22')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        
        // Week 5
        GridCol() {
          Text('23')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('24')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('25')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('26')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('27')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('28')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('29')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        
        // Week 6
        GridCol() {
          Text('30')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Text('31')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .textAlign(TextAlign.Center)
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
        GridCol() {
          Blank()
        }
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      
      // Action buttons
      Row() {
        Button('Cancel')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .onClick(() => {
            this.showDatePicker = false;
          })
        
        Blank()
        
        Button('Next')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .onClick(() => {
            this.showDatePicker = false;
            this.showTimePicker = true;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.primaryContainer)
      .borderRadius({ topLeft: AppTokens.Shapes.extraLarge, topRight: AppTokens.Shapes.extraLarge })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.extraLarge)
  }

  @Builder
  TimePickerDialog() {
    Column() {
      Text('Set time')
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .margin({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg })
      
      TimePicker()
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })
      
      Row() {
        Button('Cancel')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .onClick(() => {
            this.showTimePicker = false;
          })
        
        Blank()
        
        Button('Set')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .onClick(() => {
            this.showTimePicker = false;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.primaryContainer)
      .borderRadius({ topLeft: AppTokens.Shapes.extraLarge, topRight: AppTokens.Shapes.extraLarge })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.extraLarge)
  }
}