```ts
import { Component, State } from '@ohos/arkui';

@Entry
@Component
struct RootScreen {
  @State private knobPositionX: number = 0;
  @State private knobPositionY: number = 0;
  @State private powerOn: boolean = false;

  private readonly primaryColor: string = '#FF7A00';
  private readonly secondaryColor: string = '#FFC300';
  private readonly tertiaryColor: string = '#FFF3C0';
  private readonly backgroundColor: string = '#FFF8E7';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#FFEBC8';
  private readonly outlineColor: string = '#BCA789';
  private readonly successColor: string = '#28A745';
  private readonly warningColor: string = '#FFC107';
  private readonly errorColor: string = '#DC3545';
  private readonly onPrimaryColor: string = '#FFFFFF';
  private readonly onSecondaryColor: string = '#1E1E1E';
  private readonly onTertiaryColor: string = '#1E1E1E';
  private readonly onBackgroundColor: string = '#1E1E1E';
  private readonly onSurfaceColor: string = '#1E1E1E';

  private readonly displayFontSize: number = 28;
  private readonly titleFontSize: number = 18;
  private readonly bodyFontSize: number = 14;
  private readonly labelFontSize: number = 12;

  private readonly spacingXs: number = 4;
  private readonly spacingSm: number = 8;
  private readonly spacingMd: number = 12;
  private readonly spacingLg: number = 16;
  private readonly spacingXl: number = 24;
  private readonly spacingXxl: number = 32;

  private readonly smallRadius: number = 8;
  private readonly mediumRadius: number = 14;
  private readonly largeRadius: number = 24;

  private readonly elevationLevel1: number = 2;
  private readonly elevationLevel2: number = 4;

  private readonly canvasSize: number = 280;
  private readonly knobRadius: number = 24;
  private readonly outerCircleRadius: number = 200;

  private readonly buttonSize: number = 80;

  private readonly progressHeight: number = 6;

  private readonly screenWidth: number = 720;
  private readonly screenHeight: number = 1280;

  private readonly canvasCenterX: number = this.canvasSize / 2;
  private readonly canvasCenterY: number = this.canvasSize / 2;

  private readonly initialKnobX: number = this.canvasCenterX;
  private readonly initialKnobY: number = this.canvasCenterY;

  private readonly maxKnobDistance: number = this.outerCircleRadius - this.knobRadius;

  private readonly progressMaxValue: number = 400;

  private readonly knobPositionXDefault: number = this.canvasCenterX;
  private readonly knobPositionYDefault: number = this.canvasCenterY;

  private readonly knobPositionXMin: number = this.knobRadius;
  private readonly knobPositionXMax: number = this.canvasSize - this.knobRadius;
  private readonly knobPositionYMin: number = this.knobRadius;
  private readonly knobPositionYMax: number = this.canvasSize - this.knobRadius;

  private readonly knobPositionXRange: number = this.knobPositionXMax - this.knobPositionXMin;
  private readonly knobPositionYRange: number = this.knobPositionYMax - this.knobPositionYMin;

  private readonly knobPositionXStep: number = this.knobPositionXRange / 100;
  private readonly knobPositionYStep: number = this.knobPositionYRange / 100;

  private readonly knobPositionXDefaultIndex: number = 50;
  private readonly knobPositionYDefaultIndex: number = 50;

  private readonly knobPositionXIndexMin: number = 0;
  private readonly knobPositionXIndexMax: number = 100;
  private readonly knobPositionYIndexMin: number = 0;
  private readonly knobPositionYIndexMax: number = 100;

  private readonly knobPositionXIndexDefault: number = 50;
  private readonly knobPositionYIndexDefault: number = 50;

  private readonly knobPositionXIndexStep: number = 1;
  private readonly knobPositionYIndexStep: number = 1;

  private readonly knobPositionXIndexRange: number = this.knobPositionXIndexMax - this.knobPositionXIndexMin;
  private readonly knobPositionYIndexRange: number = this.knobPositionYIndexMax - this.knobPositionYIndexMin;

  private readonly knobPositionXIndexDefaultValue: number = this.knobPositionXIndexDefault;
  private readonly knobPositionYIndexDefaultValue: number = this.knobPositionYIndexDefault;

  private readonly knobPositionXIndexMinValue: number = this.knobPositionXIndexMin;
  private readonly knobPositionXIndexMaxValue: number = this.knobPositionXIndexMax;
  private readonly knobPositionYIndexMinValue: number = this.knobPositionYIndexMin;
  private readonly knobPositionYIndexMaxValue: number = this.knobPositionYIndexMax;

  private readonly knobPositionXIndexStepValue: number = this.knobPositionXIndexStep;
  private readonly knobPositionYIndexStepValue: number = this.knobPositionYIndexStep;

  private readonly knobPositionXIndexRangeValue: number = this.knobPositionXIndexRange;
  private readonly knobPositionYIndexRangeValue: number = this.knobPositionYIndexRange;

  private readonly knobPositionXIndexDefaultValue2: number = this.knobPositionXIndexDefaultValue;
  private readonly knobPositionYIndexDefaultValue2: number = this.knobPositionYIndexDefaultValue;

  private readonly knobPositionXIndexMinValue2: number = this.knobPositionXIndexMinValue;
  private readonly knobPositionXIndexMaxValue2: number = this.knobPositionXIndexMaxValue;
  private readonly knobPositionYIndexMinValue2: number = this.knobPositionYIndexMinValue;
  private readonly knobPositionYIndexMaxValue2: number = this.knobPositionYIndexMaxValue;

  private readonly knobPositionXIndexStepValue2: number = this.knobPositionXIndexStepValue;
  private readonly knobPositionYIndexStepValue2: number = this.knobPositionYIndexStepValue;

  private readonly knobPositionXIndexRangeValue2: number = this.knobPositionXIndexRangeValue;
  private readonly knobPositionYIndexRangeValue2: number = this.knobPositionYIndexRangeValue;

  private readonly knobPositionXIndexDefaultValue3: number = this.knobPositionXIndexDefaultValue2;
  private readonly knobPositionYIndexDefaultValue3: number = this.knobPositionYIndexDefaultValue2;

  private readonly knobPositionXIndexMinValue3: number = this.knobPositionXIndexMinValue2;
  private readonly knobPositionXIndexMaxValue3: number = this.knobPositionXIndexMaxValue2;
  private readonly knobPositionYIndexMinValue3: number = this.knobPositionYIndexMinValue2;
  private readonly knobPositionYIndexMaxValue3: number = this.knobPositionYIndexMaxValue2;

  private readonly knobPositionXIndexStepValue3: number = this.knobPositionXIndexStepValue2;
  private readonly knobPositionYIndexStepValue3: number = this.knobPositionYIndexStepValue2;

  private readonly knobPositionXIndexRangeValue3: number = this.knobPositionXIndexRangeValue2;
  private readonly knobPositionYIndexRangeValue3: number = this.knobPositionYIndexRangeValue2;

  private readonly knobPositionXIndexDefaultValue4: number = this.knobPositionXIndexDefaultValue3;
  private readonly knobPositionYIndexDefaultValue4: number = this.knobPositionYIndexDefaultValue3;

  private readonly knobPositionXIndexMinValue4: number = this.knobPositionXIndexMinValue3;
  private readonly knobPositionXIndexMaxValue4: number = this.knobPositionXIndexMaxValue3;
  private readonly knobPositionYIndexMinValue4: number = this.knobPositionYIndexMinValue3;
  private readonly knobPositionYIndexMaxValue4: number = this.knobPositionYIndexMaxValue3;

  private readonly knobPositionXIndexStepValue4: number = this.knobPositionXIndexStepValue3;
  private readonly knobPositionYIndexStepValue4: number = this.knobPositionYIndexStepValue3;

  private readonly knobPositionXIndexRangeValue4: number = this.knobPositionXIndexRangeValue3;
  private readonly knobPositionYIndexRangeValue4: number = this.knobPositionYIndexRangeValue3;

  private readonly knobPositionXIndexDefaultValue5: number = this.knobPositionXIndexDefaultValue4;
  private readonly knobPositionYIndexDefaultValue5: number = this.knobPositionYIndexDefaultValue4;

  private readonly knobPositionXIndexMinValue5: number = this.knobPositionXIndexMinValue4;
  private readonly knobPositionXIndexMaxValue5: number = this.knobPositionXIndexMaxValue4;
  private readonly knobPositionYIndexMinValue5: number = this.knobPositionYIndexMinValue4;
  private readonly knobPositionYIndexMaxValue5: number = this.knobPositionYIndexMaxValue4;

  private readonly knobPositionXIndexStepValue5: number = this.knobPositionXIndexStepValue4;
  private readonly knobPositionYIndexStepValue5: number = this.knobPositionYIndexStepValue4;

  private readonly knobPositionXIndexRangeValue5: number = this.knobPositionXIndexRangeValue4;
  private readonly knobPositionYIndexRangeValue5: number = this.knobPositionYIndexRangeValue4;

  private readonly knobPositionXIndexDefaultValue6: number = this.knobPositionXIndexDefaultValue5;
  private readonly knobPositionYIndexDefaultValue6: number = this.knobPositionYIndexDefaultValue5;

  private readonly knobPositionXIndexMinValue6: number = this.knobPositionXIndexMinValue5;
  private readonly knobPositionXIndexMaxValue6: number = this.knobPositionXIndexMaxValue5;
  private readonly knobPositionYIndexMinValue6: number = this.knobPositionYIndexMinValue5;
  private readonly knobPositionYIndexMaxValue6: number = this.knobPositionYIndexMaxValue5;

  private readonly knobPositionXIndexStepValue6: number = this.knobPositionXIndexStepValue5;
  private readonly knobPositionYIndexStepValue6: number = this.knobPositionYIndexStepValue5;

  private readonly knobPositionXIndexRangeValue6: number = this.knobPositionXIndexRangeValue5;
  private readonly knobPositionYIndexRangeValue6: number = this.knobPositionYIndexRangeValue5;

  private readonly knobPositionXIndexDefaultValue7: number = this.knobPositionXIndexDefaultValue6;
  private readonly knobPositionYIndexDefaultValue7: number = this.knobPositionYIndexDefaultValue6;

  private readonly knobPositionXIndexMinValue7: number = this.knobPositionXIndexMinValue6;
  private readonly knobPositionXIndexMaxValue7: number = this.knobPositionXIndexMaxValue6;
  private readonly knobPositionYIndexMinValue7: number = this.knobPositionYIndexMinValue6;
  private readonly knobPositionYIndexMaxValue7: number = this.knobPositionYIndexMaxValue6;

  private readonly knobPositionXIndexStepValue7: number = this.knobPositionXIndexStepValue6;
  private readonly knobPositionYIndexStepValue7: number = this.knobPositionYIndexStepValue6;

  private readonly knobPositionXIndexRangeValue7: number = this.knobPositionXIndexRangeValue6;
  private readonly knobPositionYIndexRangeValue7: number = this.knobPositionYIndexRangeValue6;

  private readonly knobPositionXIndexDefaultValue8: number = this.knobPositionXIndexDefaultValue7;
  private readonly knobPositionYIndexDefaultValue8: number = this.knobPositionYIndexDefaultValue7;

  private readonly knobPositionXIndexMinValue8: number = this.knobPositionXIndexMinValue7;
  private readonly knobPositionXIndexMaxValue8: number = this.knobPositionXIndexMaxValue7;
  private readonly knobPositionYIndexMinValue8: number = this.knobPositionYIndexMinValue7;
  private readonly knobPositionYIndexMaxValue8: number = this.knobPositionYIndexMaxValue7;

  private readonly knobPositionXIndexStepValue8: number = this.knobPositionXIndexStepValue7;
  private readonly knobPositionYIndexStepValue8: number = this.knobPositionYIndexStepValue7;

  private readonly knobPositionXIndexRangeValue8: number = this.knobPositionXIndexRangeValue7;
  private readonly knobPositionYIndexRangeValue8: number = this.knobPositionYIndexRangeValue7;

  private readonly knobPositionXIndexDefaultValue9: number = this.knobPositionXIndexDefaultValue8;
  private readonly knobPositionYIndexDefaultValue9: number = this.knobPositionYIndexDefaultValue8;

  private readonly knobPositionXIndexMinValue9: number = this.knobPositionXIndexMinValue8;
  private readonly knobPositionXIndexMaxValue9: number = this.knobPositionXIndexMaxValue8;
  private readonly knobPositionYIndexMinValue9: number = this.knobPositionYIndexMinValue8;
  private readonly knobPositionYIndexMaxValue9: number = this.knobPositionYIndexMaxValue8;

  private readonly knobPositionXIndexStepValue9: number = this.knobPositionXIndexStepValue8;
  private readonly knobPositionYIndexStepValue9: number = this.knobPositionYIndexStepValue8;

  private readonly knobPositionXIndexRangeValue9: number = this.knobPositionXIndexRangeValue8;
  private readonly knobPositionYIndexRangeValue9: number = this.knobPositionYIndexRangeValue8;

  private readonly knobPositionXIndexDefaultValue10: number = this.knobPositionXIndexDefaultValue9;
  private readonly knobPositionYIndexDefaultValue10: number = this.knobPositionYIndexDefaultValue9;

  private readonly knobPositionXIndexMinValue10: number = this.knobPositionXIndexMinValue9;
  private readonly knobPositionXIndexMaxValue10: number = this.knobPositionXIndexMaxValue9;
  private readonly knobPositionYIndexMinValue10: number = this.knobPositionYIndexMinValue9;
  private readonly knobPositionYIndexMaxValue10: number = this.knobPositionYIndexMaxValue9;

  private readonly knobPositionXIndexStepValue10: number = this.knobPositionXIndexStepValue9;
  private readonly knobPositionYIndexStepValue10: number = this.knobPositionYIndexStepValue9;

  private readonly knobPositionXIndexRangeValue10: number = this.knobPositionXIndexRangeValue9;
  private readonly knobPositionYIndexRangeValue10: number = this.knobPositionYIndexRangeValue9;

  private readonly knobPositionXIndexDefaultValue11: number = this.knobPositionXIndexDefaultValue10;
  private readonly knobPositionYIndexDefaultValue11: number = this.knobPositionYIndexDefaultValue10;

  private readonly knobPositionXIndexMinValue11: number = this.knobPositionXIndexMinValue10;
  private readonly knobPositionXIndexMaxValue11: number = this.knobPositionXIndexMaxValue10;
  private readonly knobPositionYIndexMinValue11: number = this.knobPositionYIndexMinValue10;
  private readonly knobPositionYIndexMaxValue11: number = this.knobPositionYIndexMaxValue10;

  private readonly knobPositionXIndexStepValue11: number = this.knobPositionXIndexStepValue10;
  private readonly knobPositionYIndexStepValue11: number = this.knobPositionYIndexStepValue10;

  private readonly knobPositionXIndexRangeValue11: number = this.knobPositionXIndexRangeValue10;
  private readonly knobPositionYIndexRangeValue11: number = this.knobPositionYIndexRangeValue10;

  private readonly knobPositionXIndexDefaultValue12: number = this.knobPositionXIndexDefaultValue11;
  private readonly knobPositionYIndexDefaultValue12: number = this.knobPositionYIndexDefaultValue11;

  private readonly knobPositionXIndexMinValue12: number = this.knobPositionXIndexMinValue11;
  private readonly knobPositionXIndexMaxValue12: number = this.knobPositionXIndexMaxValue11;
  private readonly knobPositionYIndexMinValue12: number = this.knobPositionYIndexMinValue11;
  private readonly knobPositionYIndexMaxValue12: number = this.knobPositionYIndexMaxValue11;

  private readonly knobPositionXIndexStepValue12: number = this.knobPositionXIndexStepValue11;
  private readonly knobPositionYIndexStepValue12: number = this.knobPositionYIndexStepValue11;

  private readonly knobPositionXIndexRangeValue12: number = this.knobPositionXIndexRangeValue11;
  private readonly knobPositionYIndexRangeValue12: number = this.knobPositionYIndexRangeValue11;

  private readonly knobPositionXIndexDefaultValue13: number = this.knobPositionXIndexDefaultValue12;
  private readonly knobPositionYIndexDefaultValue13: number = this.knobPositionYIndexDefaultValue12;

  private readonly knobPositionXIndexMinValue13: number = this.knobPositionXIndexMinValue12;
  private readonly knobPositionXIndexMaxValue13: number = this.knobPositionXIndexMaxValue12;
  private readonly knobPositionYIndexMinValue13: number = this.knobPositionYIndexMinValue12;
  private readonly knobPositionYIndexMaxValue13: number = this.knobPositionYIndexMaxValue12;

  private readonly knobPositionXIndexStepValue13: number = this.knobPositionXIndexStepValue12;
  private readonly knobPositionYIndexStepValue13: number = this.knobPositionYIndexStepValue12;

  private readonly knobPositionXIndexRangeValue13: number = this.knobPositionXIndexRangeValue12;
  private readonly knobPositionYIndexRangeValue13: number = this.knobPositionYIndexRangeValue12;

  private readonly knobPositionXIndexDefaultValue14: number = this.knobPositionXIndexDefaultValue13;
  private readonly knobPositionYIndexDefaultValue14: number = this.knobPositionYIndexDefaultValue13;

  private readonly knobPositionXIndexMinValue14: number = this.knobPositionXIndexMinValue13;
  private readonly knobPositionXIndexMaxValue14: number = this.knobPositionXIndexMaxValue13;
  private readonly knobPositionYIndexMinValue14: number = this.knobPositionYIndexMinValue13;
  private readonly knobPositionYIndexMaxValue14: number = this.knobPositionYIndexMaxValue13;

  private readonly knobPositionXIndexStepValue14: number = this.knobPositionXIndexStepValue13;
  private readonly knobPositionYIndexStepValue14: number = this.knobPositionYIndexStepValue13;

  private readonly knobPositionXIndexRangeValue14: number = this.knobPositionXIndexRangeValue13;
  private readonly knobPositionYIndexRangeValue14: number = this.knobPositionYIndexRangeValue13;

  private readonly knobPositionXIndexDefaultValue15: number = this.knobPositionXIndexDefaultValue14;
  private readonly knobPositionYIndexDefaultValue15: number = this.knobPositionYIndexDefaultValue14;

  private readonly knobPositionXIndexMinValue15: number = this.knobPositionXIndexMinValue14;
  private readonly knobPositionXIndexMaxValue15: number = this.knobPositionXIndexMaxValue14;
  private readonly knobPositionYIndexMinValue15: number = this.knobPositionYIndexMinValue14;
  private readonly knobPositionYIndexMaxValue15: number = this.knobPositionYIndexMaxValue14;

  private readonly knobPositionXIndexStepValue15: number = this.knobPositionXIndexStepValue14;
  private readonly knobPositionYIndexStepValue15: number = this.knobPositionYIndexStepValue14;

  private readonly knobPositionXIndexRangeValue15: number = this.knobPositionXIndexRangeValue14;
  private readonly knobPositionYIndexRangeValue15: number = this.knobPositionYIndexRangeValue14;

  private readonly knobPositionXIndexDefaultValue16: number = this.knobPositionXIndexDefaultValue15;
  private readonly knobPositionYIndexDefaultValue16: number = this.knobPositionYIndexDefaultValue15;

  private readonly knobPositionXIndexMinValue16: number = this.knobPositionXIndexMinValue15;
  private readonly knobPositionXIndexMaxValue16: number = this.knobPositionXIndexMaxValue15;
  private readonly knobPositionYIndexMinValue16: number = this.knobPositionYIndexMinValue15;
  private readonly knobPositionYIndexMaxValue16: number = this.knobPositionYIndexMaxValue15;

  private readonly knobPositionXIndexStepValue16: number = this.knobPositionXIndexStepValue15;
  private readonly knobPositionYIndexStepValue16: number = this.knobPositionYIndexStepValue15;

  private readonly knobPositionXIndexRangeValue16: number = this.knobPositionXIndexRangeValue15;
  private readonly knobPositionYIndexRangeValue16: number = this.knobPositionYIndexRangeValue15;

  private readonly knobPositionXIndexDefaultValue17: number = this.knobPositionXIndexDefaultValue16;
  private readonly knobPositionYIndexDefaultValue17: number = this.knobPositionYIndexDefaultValue16;

  private readonly knobPositionXIndexMinValue17: number = this.knobPositionXIndexMinValue16;
  private readonly knobPositionXIndexMaxValue17: number = this.knobPositionXIndexMaxValue16;
  private readonly knobPositionYIndexMinValue17: number = this.knobPositionYIndexMinValue16;
  private readonly knobPositionYIndexMaxValue17: number = this.knobPositionYIndexMaxValue16;

  private readonly knobPositionXIndexStepValue17: number = this.knobPositionXIndexStepValue16;
  private readonly knobPositionYIndexStepValue17: number = this.knobPositionYIndexStepValue16;

  private readonly knobPositionXIndexRangeValue17: number = this.knobPositionXIndexRangeValue16;
  private readonly knobPositionYIndexRangeValue17: number = this.knobPositionYIndexRangeValue16;

  private readonly knobPositionXIndexDefaultValue18: number = this.knobPositionXIndexDefaultValue17;
  private readonly knobPositionYIndexDefaultValue18: number = this.knobPositionYIndexDefaultValue17;

  private readonly knobPositionXIndexMinValue18: number = this.knobPositionXIndexMinValue17;
  private readonly knobPositionXIndexMaxValue18: number = this.knobPositionXIndexMaxValue17;
  private readonly knobPositionYIndexMinValue18: number = this.knobPositionYIndexMinValue17;
  private readonly knobPositionYIndexMaxValue18: number = this.knobPositionYIndexMaxValue17;

  private readonly knobPositionXIndexStepValue18: number = this.knobPositionXIndexStepValue17;
  private readonly knobPositionYIndexStepValue18: number = this.knobPositionYIndexStepValue17;

  private readonly knobPositionXIndexRangeValue18: number = this.knobPositionXIndexRangeValue17;
  private readonly knobPositionYIndexRangeValue18: number = this.knobPositionYIndexRangeValue17;

  private readonly knobPositionXIndexDefaultValue19: number = this.knobPositionXIndexDefaultValue18;
  private readonly knobPositionYIndexDefaultValue19: number = this.knobPositionYIndexDefaultValue18;

  private readonly knobPositionXIndexMinValue19: number = this.knobPositionXIndexMinValue18;
  private readonly knobPositionXIndexMaxValue19: number = this.knobPositionXIndexMaxValue18;
  private readonly knobPositionYIndexMinValue19: number = this.knobPositionYIndexMinValue18;
  private readonly knobPositionYIndexMaxValue19: number = this.knobPositionYIndexMaxValue18;

  private readonly knobPositionXIndexStepValue19: number = this.knobPositionXIndexStepValue18;
  private readonly knobPositionYIndexStepValue19: number = this.knobPositionYIndexStepValue18;

  private readonly knobPositionXIndexRangeValue19: number = this.knobPositionXIndexRangeValue18;
  private readonly knobPositionYIndexRangeValue19: number = this.knobPositionYIndexRangeValue18;

  private readonly knobPositionXIndexDefaultValue20: number = this.knobPositionXIndexDefaultValue19;
  private readonly knobPositionYIndexDefaultValue20: number = this.knobPositionYIndexDefaultValue19;

  private readonly knobPositionXIndexMinValue20: number = this.knobPositionXIndexMinValue19;
  private readonly knobPositionXIndexMaxValue20: number = this.knobPositionXIndexMaxValue19;
  private readonly knobPositionYIndexMinValue20: number = this.knobPositionYIndexMinValue19;
  private readonly knobPositionYIndexMaxValue20: number = this.knobPositionYIndexMaxValue19;

  private readonly knobPositionXIndexStepValue20: number = this.knobPositionXIndexStepValue19;
  private readonly knobPositionYIndexStepValue20: number = this.knobPositionYIndexStepValue19;

  private readonly knobPositionXIndexRangeValue20: number = this.knobPositionXIndexRangeValue19;
  private readonly knobPositionYIndexRangeValue20: number = this.knobPositionYIndexRangeValue19;

  private readonly knobPositionXIndexDefaultValue21: number = this.knobPositionXIndexDefaultValue20;
  private readonly knobPositionYIndexDefaultValue21: number = this.knobPositionYIndexDefaultValue20;

  private readonly knobPositionXIndexMinValue21: number = this.knobPositionXIndexMinValue20;
  private readonly knobPositionXIndexMaxValue21: number = this.knobPositionXIndexMaxValue20;
  private readonly knobPositionYIndexMinValue21: number = this.knobPositionYIndexMinValue20;
  private readonly knobPositionYIndexMaxValue21: number = this.knobPositionYIndexMaxValue20;

  private readonly knobPositionXIndexStepValue21: number = this.knobPositionXIndexStepValue20;
  private readonly knobPositionYIndexStepValue21: number = this.knobPositionYIndexStepValue20;

  private readonly knobPositionXIndexRangeValue21: number = this.knobPositionXIndexRangeValue20;
  private readonly knobPositionYIndexRangeValue21: number = this.knobPositionYIndexRangeValue20;

  private readonly knobPositionXIndexDefaultValue22: number = this.knobPositionXIndexDefaultValue21;
  private readonly knobPositionYIndexDefaultValue22: number = this.knobPositionYIndexDefaultValue21;

  private readonly knobPositionXIndexMinValue22: number = this.knobPositionXIndexMinValue21;
  private readonly knobPositionXIndexMaxValue22: number = this.knobPositionXIndexMaxValue21;
  private readonly knobPositionYIndexMinValue22: number = this.knobPositionYIndexMinValue21;
  private readonly knobPositionYIndexMaxValue22: number = this.knobPositionYIndexMaxValue21;

  private readonly knobPositionXIndexStepValue22: number = this.knobPositionXIndexStepValue21;
  private readonly knobPositionYIndexStepValue22: number = this.knobPositionYIndexStepValue21;

  private readonly knobPositionXIndexRangeValue22: number = this.knobPositionXIndexRangeValue21;
  private readonly knobPositionYIndexRangeValue22: number = this.knobPositionYIndexRangeValue21;

  private readonly knobPositionXIndexDefaultValue23: number = this.knobPositionXIndexDefaultValue22;
  private readonly knobPositionYIndexDefaultValue23: number = this.knobPositionYIndexDefaultValue22;

  private readonly knobPositionXIndexMinValue23: number = this.knobPositionXIndexMinValue22;
  private readonly knobPositionXIndexMaxValue23: number = this.knobPositionXIndexMaxValue22;
  private readonly knobPositionYIndexMinValue23: number = this.knobPositionYIndexMinValue22;
  private readonly knobPositionYIndexMaxValue23: number = this.knobPositionYIndexMaxValue22;

  private readonly knobPositionXIndexStepValue23: number = this.knobPositionXIndexStepValue22;
  private readonly knobPositionYIndexStepValue23: number = this.knobPositionYIndexStepValue22;

  private readonly knobPositionXIndexRangeValue23: number = this.knobPositionXIndexRangeValue22;
  private readonly knobPositionYIndexRangeValue23: number = this.knobPositionYIndexRangeValue22;

  private readonly knobPositionXIndexDefaultValue24: number = this.knobPositionXIndexDefaultValue23;
  private readonly knobPositionYIndexDefaultValue24: number = this.knobPositionYIndexDefaultValue23;

  private readonly knobPositionXIndexMinValue24: number = this.knobPositionXIndexMinValue23;
  private readonly knobPositionXIndexMaxValue24: number = this.knobPositionXIndexMaxValue23;
  private readonly knobPositionYIndexMinValue24: number = this.knobPositionYIndexMinValue23;
  private readonly knobPositionYIndexMaxValue24: number = this.knobPositionYIndexMaxValue23;

  private readonly knobPositionXIndexStepValue24: number = this.knobPositionXIndexStepValue23;
  private readonly knobPositionYIndexStepValue24: number = this.knobPositionYIndexStepValue23;

  private readonly knobPositionXIndexRangeValue24: number = this.knobPositionXIndexRangeValue23;
  private readonly knobPositionYIndexRangeValue24: number = this.knobPositionYIndexRangeValue23;

  private readonly knobPositionXIndexDefaultValue25: number = this.knobPositionXIndexDefaultValue24;
  private readonly knobPositionYIndexDefaultValue25: number = this.knobPositionYIndexDefaultValue24;

  private readonly knobPositionXIndexMinValue25: number = this.knobPositionXIndexMinValue24;
  private readonly knobPositionXIndexMaxValue25: number = this.knobPositionXIndexMaxValue24;
  private readonly knobPositionYIndexMinValue25: number = this.knobPositionYIndexMinValue24;
  private readonly knobPositionYIndexMaxValue25: number = this.knobPositionYIndexMaxValue24;

  private readonly knobPositionXIndexStepValue25: number = this.knobPositionXIndexStepValue24;
  private readonly knobPositionYIndexStepValue25: number = this.knobPositionYIndexStepValue24;

  private readonly knobPositionXIndexRangeValue25: number = this.knobPositionXIndexRangeValue24;
  private readonly knobPositionYIndexRangeValue25: number = this.knobPositionYIndexRangeValue24;

  private readonly knobPositionXIndexDefaultValue26: number = this.knobPositionXIndexDefaultValue25;
  private readonly knobPositionYIndexDefaultValue26: number = this.knobPositionYIndexDefaultValue25;

  private readonly knobPositionXIndexMinValue26: number = this.knobPositionXIndexMinValue25;
  private readonly knobPositionXIndexMaxValue26: number = this.knobPositionXIndexMaxValue25;
  private readonly knobPositionYIndexMinValue26: number = this.knobPositionYIndexMinValue25;
  private readonly knobPositionYIndexMaxValue26: number = this.knobPositionYIndexMaxValue25;

  private readonly knobPositionXIndexStepValue26: number = this.knobPositionXIndexStepValue25;
  private readonly knobPositionYIndexStepValue26: number = this.knobPositionYIndexStepValue25;

  private readonly knobPositionXIndexRangeValue26: number = this.knobPositionXIndexRangeValue25;
  private readonly knobPositionYIndexRangeValue26: number = this.knobPositionYIndexRangeValue25;

  private readonly knobPositionXIndexDefaultValue27: number = this.knobPositionXIndexDefaultValue26;
  private readonly knobPositionYIndexDefaultValue27: number = this.knobPositionYIndexDefaultValue26;

  private readonly knobPositionXIndexMinValue27: number = this.knobPositionXIndexMinValue26;
  private readonly knobPositionXIndexMaxValue27: number = this.knobPositionXIndexMaxValue26;
  private readonly knobPositionYIndexMinValue27: number = this.knobPositionYIndexMinValue26;
  private readonly knobPositionYIndexMaxValue27: number = this.knobPositionYIndexMaxValue26;

  private readonly knobPositionXIndexStepValue27: number = this.knobPositionXIndexStepValue26;
  private readonly knobPositionYIndexStepValue27: number = this.knobPositionYIndexStepValue26;

  private readonly knobPositionXIndexRangeValue27: number = this.knobPositionXIndexRangeValue26;
  private readonly knobPositionYIndexRangeValue27: number = this.knobPositionYIndexRangeValue26;

  private readonly knobPositionXIndexDefaultValue28: number = this.knobPositionXIndexDefaultValue27;
  private readonly knobPositionYIndexDefaultValue28: number = this.knobPositionYIndexDefaultValue27;

  private readonly knobPositionXIndexMinValue28: number = this.knobPositionXIndexMinValue27;
  private readonly knobPositionXIndexMaxValue28: number = this.knobPositionXIndexMaxValue27;
  private readonly knobPositionYIndexMinValue28: number = this.knobPositionYIndexMinValue27;
  private readonly knobPositionYIndexMaxValue28: number = this.knobPositionYIndexMaxValue27;

  private readonly knobPositionXIndexStepValue28: number = this.knobPositionXIndexStepValue27;
  private readonly knobPositionYIndexStepValue28: number = this.knobPositionYIndexStepValue27;

  private readonly knobPositionXIndexRangeValue28: number = this.knobPositionXIndexRangeValue27;
  private readonly knobPositionYIndexRangeValue28: number = this.knobPositionYIndexRangeValue27;

  private readonly knobPositionXIndexDefaultValue29: number = this.knobPositionXIndexDefaultValue28;
  private readonly knobPositionYIndexDefaultValue29: number = this.knobPositionYIndexDefaultValue28;

  private readonly knobPositionXIndexMinValue29: number = this.knobPositionXIndexMinValue28;
  private readonly knobPositionXIndexMaxValue29: number = this.knobPositionXIndexMaxValue28;
  private readonly knobPositionYIndexMinValue29: number = this.knobPositionYIndexMinValue28;
  private readonly knobPositionYIndexMaxValue29: number = this.knobPositionYIndexMaxValue28;

  private readonly knobPositionXIndexStepValue29: number = this.knobPositionXIndexStepValue28;
  private readonly knobPositionYIndexStepValue29: number = this.knobPositionYIndexStepValue28;

  private readonly knobPositionXIndexRangeValue29: number = this.knobPositionXIndexRangeValue28;
  private readonly knobPositionYIndexRangeValue29: number = this.knobPositionYIndexRangeValue28;

  private readonly knobPositionXIndexDefaultValue30: number = this.knobPositionXIndexDefaultValue29;
  private readonly knobPositionYIndexDefaultValue30: number = this.knobPositionYIndexDefaultValue29;

  private readonly knobPositionXIndexMinValue30: number = this.knobPositionXIndexMinValue29;
  private readonly knobPositionXIndexMaxValue30: number = this.knobPositionXIndexMaxValue29;
  private readonly knobPositionYIndexMinValue30: number = this.knobPositionYIndexMinValue29;
  private readonly knobPositionYIndexMaxValue30: number = this.knobPositionYIndexMaxValue29;

  private readonly knobPositionXIndexStepValue30: number = this.knobPositionXIndexStepValue29;
  private readonly knobPositionYIndexStepValue30: number = this.knobPositionYIndexStepValue29;

  private readonly knobPositionXIndexRangeValue30: number = this.knobPositionXIndexRangeValue29;
  private readonly knobPositionYIndexRangeValue30: number = this.knobPositionYIndexRangeValue29;

  private readonly knobPositionXIndexDefaultValue31: number = this.knobPositionXIndexDefaultValue30;
  private readonly knobPositionYIndexDefaultValue31: number = this.knobPositionYIndexDefaultValue30;

  private readonly knobPositionXIndexMinValue31: number = this.knobPositionXIndexMinValue30;
  private readonly knobPositionXIndexMaxValue31: number = this.knobPositionXIndexMaxValue30;
  private readonly knobPositionYIndexMinValue31: number = this.knobPositionYIndexMinValue30;
  private readonly knobPositionYIndexMaxValue31: number = this.knobPositionYIndexMaxValue30;

  private readonly knobPositionXIndexStepValue31: number = this.knobPositionXIndexStepValue30;
  private readonly knobPositionYIndexStepValue31: number = this.knobPositionYIndexStepValue30;

  private readonly knobPositionXIndexRangeValue31: number = this.knobPositionXIndexRangeValue30;
  private readonly knobPositionYIndexRangeValue31: number = this.knobPositionYIndexRangeValue30;

  private readonly knobPositionXIndexDefaultValue32: number = this.knobPositionXIndexDefaultValue31;
  private readonly knobPositionYIndexDefaultValue32: number = this.knobPositionYIndexDefaultValue31;

  private readonly knobPositionXIndexMinValue32: number = this.knobPositionXIndexMinValue31;
  private readonly knobPositionXIndexMaxValue32: number = this.knobPositionXIndexMaxValue31;
  private readonly knobPositionYIndexMinValue32: number = this.knobPositionYIndexMinValue31;
  private readonly knobPositionYIndexMaxValue32: number = this.knobPositionYIndexMaxValue31;

  private readonly knobPositionXIndexStepValue32: number = this.knobPositionXIndexStepValue31;
  private readonly knobPositionYIndexStepValue32: number = this.knobPositionYIndexStepValue31;

  private readonly knobPositionXIndexRangeValue32: number = this.knobPositionXIndexRangeValue31;
  private readonly knobPositionYIndexRangeValue32: number = this.knobPositionYIndexRangeValue31;

  private readonly knobPositionXIndexDefaultValue33: number = this.knobPositionXIndexDefaultValue32;
  private readonly knobPositionYIndexDefaultValue33: number = this.knobPositionYIndexDefaultValue32;

  private readonly knobPositionXIndexMinValue33: number = this.knobPositionXIndexMinValue32;
  private readonly knobPositionXIndexMaxValue33: number = this.knobPositionXIndexMaxValue32;
  private readonly knobPositionYIndexMinValue33: number = this.knobPositionYIndexMinValue32;
  private readonly knobPositionYIndexMaxValue33: number = this.knobPositionYIndexMaxValue32;

  private readonly knobPositionXIndexStepValue33: number = this.knobPositionXIndexStepValue32;
  private readonly knobPositionYIndexStepValue33: number = this.knobPositionYIndexStepValue32;

  private readonly knobPositionXIndexRangeValue33: number = this.knobPositionXIndexRangeValue32;
  private readonly knobPositionYIndexRangeValue33: number = this.knobPositionYIndexRangeValue32;

  private readonly knobPositionXIndexDefaultValue34: number = this.knobPositionXIndexDefaultValue33;
  private readonly knobPositionYIndexDefaultValue34: number = this.knobPositionYIndexDefaultValue33;

  private readonly knobPositionXIndexMinValue34: number = this.knobPositionXIndexMinValue33;
  private readonly knobPositionXIndexMaxValue34: number = this.knobPositionXIndexMaxValue33;
  private readonly knobPositionYIndexMinValue34: number = this.knobPositionYIndexMinValue33;
  private readonly knobPositionYIndexMaxValue34: number = this.knobPositionYIndexMaxValue33;

  private readonly knobPositionXIndexStepValue34: number = this.knobPositionXIndexStepValue33;
  private readonly knobPositionYIndexStepValue34: number = this.knobPositionYIndexStepValue33;

  private readonly knobPositionXIndexRangeValue34: number = this.knobPositionXIndexRangeValue33;
  private readonly knobPositionYIndexRangeValue34: number = this.knobPositionYIndexRangeValue33;

  private readonly knobPositionXIndexDefaultValue35: number = this.knobPositionXIndexDefaultValue34;
  private readonly knobPositionYIndexDefaultValue35: number = this.knobPositionYIndexDefaultValue34;

  private readonly knobPositionXIndexMinValue35: number = this.knobPositionXIndexMinValue34;
  private readonly knobPositionXIndexMaxValue35: number = this.knobPositionXIndexMaxValue34;
  private readonly knobPositionYIndexMinValue35: number = this.knobPositionYIndexMinValue34;
  private readonly knobPositionYIndexMaxValue35: number = this.knobPositionYIndexMaxValue34;

  private readonly knobPositionXIndexStepValue35: number = this.knobPositionXIndexStepValue34;
  private readonly knobPositionYIndexStepValue35: number = this.knobPositionYIndexStepValue34;

  private readonly knobPositionXIndexRangeValue35: number = this.knobPositionXIndexRangeValue34;
  private readonly knobPositionYIndexRangeValue35: number = this.knobPositionYIndexRangeValue34;

  private readonly knobPositionXIndexDefaultValue36: number = this.knobPositionXIndexDefaultValue35;
  private readonly knobPositionYIndexDefaultValue36: number = this.knobPositionYIndexDefaultValue35;

  private readonly knobPositionXIndexMinValue36: number = this.knobPositionXIndexMinValue35;
  private readonly knobPositionXIndexMaxValue36: number = this.knobPositionXIndexMaxValue35;
  private readonly knobPositionYIndexMinValue36: number = this.knobPositionYIndexMinValue35;
  private readonly knobPositionYIndexMaxValue36: number = this.knobPositionYIndexMaxValue35;

  private readonly knobPositionXIndexStepValue36: number = this.knobPositionXIndexStepValue35;
  private readonly knobPositionYIndexStepValue36: number = this.knobPositionYIndexStepValue35;

  private readonly knobPositionXIndexRangeValue36: number = this.knobPositionXIndexRangeValue35;
  private readonly knobPositionYIndexRangeValue36: number = this.knobPositionYIndexRangeValue35;

  private readonly knobPositionXIndexDefaultValue37: number = this.knobPositionXIndexDefaultValue36;
  private readonly knobPositionYIndexDefaultValue37: number = this.knobPositionYIndexDefaultValue36;

  private readonly knobPositionXIndexMinValue37: number = this.knobPositionXIndexMinValue36;
  private readonly knobPositionXIndexMaxValue37: number = this.knobPositionXIndexMaxValue36;
  private readonly knobPositionYIndexMinValue37: number = this.knobPositionYIndexMinValue36;
  private readonly knobPositionYIndexMaxValue37: number = this.knobPositionYIndexMaxValue36;

  private readonly knobPositionXIndexStepValue37: number = this.knobPositionXIndexStepValue36;
  private readonly knobPositionYIndexStepValue37: number = this.knobPositionYIndexStepValue36;

  private readonly knobPositionXIndexRangeValue37: number = this.knobPositionXIndexRangeValue36;
  private readonly knobPositionYIndexRangeValue37: number = this.knobPositionYIndexRangeValue36;

  private readonly knobPositionXIndexDefaultValue38: number = this.knobPositionXIndexDefaultValue37;
  private readonly knobPositionYIndexDefaultValue38: number = this.knobPositionYIndexDefaultValue37;

  private readonly knobPositionXIndexMinValue38: number = this.knobPositionXIndexMinValue37;
  private readonly knobPositionXIndexMaxValue38: number = this.knobPositionXIndexMaxValue37;
  private readonly knobPositionYIndexMinValue38: number = this.knobPositionYIndexMinValue37;
  private readonly knobPositionYIndexMaxValue38: number = this.knobPositionYIndexMaxValue37;

  private readonly knobPositionXIndexStepValue38: number = this.knobPositionXIndexStepValue37;
  private readonly knobPositionYIndexStepValue38: number = this.knobPositionYIndexStepValue37;

  private readonly knobPositionXIndexRangeValue38: number = this.knobPositionXIndexRangeValue37;
  private readonly knobPositionYIndexRangeValue38: number = this.knobPositionYIndexRangeValue37;

  private readonly knobPositionXIndexDefaultValue39: number = this.knobPositionXIndexDefaultValue38;
  private readonly knobPositionYIndexDefaultValue39: number = this.knobPositionYIndexDefaultValue38;

  private readonly knobPositionXIndexMinValue39: number = this.knobPositionXIndexMinValue38;
  private readonly knobPositionXIndexMaxValue39: number = this.knobPositionXIndexMaxValue38;
  private readonly knobPositionYIndexMinValue39: number = this.knobPositionYIndexMinValue38;
  private readonly knobPositionYIndexMaxValue39: number = this.knobPositionYIndexMaxValue38;

  private readonly knobPositionXIndexStepValue39: number = this.knobPositionXIndexStepValue38;
  private readonly knobPositionYIndexStepValue39: number = this.knobPositionYIndexStepValue38;

  private readonly knobPositionXIndexRangeValue39: number = this.knobPositionXIndexRangeValue38;
  private readonly knobPositionYIndexRangeValue39: number = this.knobPositionYIndexRangeValue38;

  private readonly knobPositionXIndexDefaultValue40: number = this.knobPositionXIndexDefaultValue39;
  private readonly knobPositionYIndexDefaultValue40: number = this.knobPositionYIndexDefaultValue39;

  private readonly knobPositionXIndexMinValue40: number = this.knobPositionXIndexMinValue39;
  private readonly knobPositionXIndexMaxValue40: number = this.knobPositionXIndexMaxValue39;
  private readonly knobPositionYIndexMinValue40: number = this.knobPositionYIndexMinValue39;
  private readonly knobPositionYIndexMaxValue40: number = this.knobPositionYIndexMaxValue39;

  private readonly knobPositionXIndexStepValue40: number = this.knobPositionXIndexStepValue39;
  private readonly knobPositionYIndexStepValue40: number = this.knobPositionYIndexStepValue39;

  private readonly knobPositionXIndexRangeValue40: number = this.knobPositionXIndexRangeValue39;
  private readonly knobPositionYIndexRangeValue40: number = this.knobPositionYIndexRangeValue39;

  private readonly knobPositionXIndexDefaultValue41: number = this.knobPositionXIndexDefaultValue40;
  private readonly knobPositionYIndexDefaultValue41: number = this.knobPositionYIndexDefaultValue40;

  private readonly knobPositionXIndexMinValue41: number = this.knobPositionXIndexMinValue40;
  private readonly knobPositionXIndexMaxValue41: number = this.knobPositionXIndexMaxValue40;
  private readonly knobPositionYIndexMinValue41: number = this.knobPositionYIndexMinValue40;
  private readonly knobPositionYIndexMaxValue41: number = this.knobPositionYIndexMaxValue40;

  private readonly knobPositionXIndexStepValue41: number = this.knobPositionXIndexStepValue40;
  private readonly knobPositionYIndexStepValue41: number = this.knobPositionYIndexStepValue40;

  private readonly knobPositionXIndexRangeValue41: number = this.knobPositionXIndexRangeValue40;
  private readonly knobPositionYIndexRangeValue41: number = this.knobPositionYIndexRangeValue40;

  private readonly knobPositionXIndexDefaultValue42: number = this.knobPositionXIndexDefaultValue41;
  private readonly knobPositionYIndexDefaultValue42: number = this.knobPositionYIndexDefaultValue41;

  private readonly knobPositionXIndexMinValue42: number = this.knobPositionXIndexMinValue41;
  private readonly knobPositionXIndexMaxValue42: number = this.knobPositionXIndexMaxValue41;
  private readonly knobPositionYIndexMinValue42: number = this.knobPositionYIndexMinValue41;
  private readonly knobPositionYIndexMaxValue42: number = this.knobPositionYIndexMaxValue41;

  private readonly knobPositionXIndexStepValue42: number = this.knobPositionXIndexStepValue41;
  private readonly knobPositionYIndexStepValue42: number = this.knobPositionYIndexStepValue41;

  private readonly knobPositionXIndexRangeValue42: number = this.knobPositionXIndexRangeValue41;
  private readonly knobPositionYIndexRangeValue42: number = this.knobPositionYIndexRangeValue41;

  private readonly knobPositionXIndexDefaultValue43: number = this.knobPositionXIndexDefaultValue42;
  private readonly knobPositionYIndexDefaultValue43: number = this.knobPositionYIndexDefaultValue42;

  private readonly knobPositionXIndexMinValue43: number = this.knobPositionXIndexMinValue42;
  private readonly knobPositionXIndexMaxValue43: number = this.knobPositionXIndexMaxValue42;
  private readonly knobPositionYIndexMinValue43: number = this.knobPositionYIndexMinValue42;
  private readonly knobPositionYIndexMaxValue43: number = this.knobPositionYIndexMaxValue42;

  private readonly knobPositionXIndexStepValue43: number = this.knobPositionXIndexStepValue42;
  private readonly knobPositionYIndexStepValue43: number = this.knobPositionYIndexStepValue42;

  private readonly knobPositionXIndexRangeValue43: number = this.knobPositionXIndexRangeValue42;
  private readonly knobPositionYIndexRangeValue43: number = this.knobPositionYIndexRangeValue42;

  private readonly knobPositionXIndexDefaultValue44: number = this.knobPositionXIndexDefaultValue43;
  private readonly knobPositionYIndexDefaultValue44: number = this.knobPositionYIndexDefaultValue43;

  private readonly knobPositionXIndexMinValue44: number = this.knobPositionXIndexMinValue43;
  private readonly knobPositionXIndexMaxValue44: number = this.knobPositionXIndexMaxValue43;
  private readonly knobPositionYIndexMinValue44: number = this.knobPositionYIndexMinValue43;
  private readonly knobPositionYIndexMaxValue44: number = this.knobPositionYIndexMaxValue43;

  private readonly knobPositionXIndexStepValue44: number = this.knobPositionXIndexStepValue43;
  private readonly knobPositionYIndexStepValue44: number = this.knobPositionYIndexStepValue43;

  private readonly knobPositionXIndexRangeValue44: number = this.knobPositionXIndexRangeValue43;
  private readonly knobPositionYIndexRangeValue44: number = this.knobPositionYIndexRangeValue43;

  private readonly knobPositionXIndexDefaultValue45: number = this.knobPositionXIndexDefaultValue44;
  private readonly knobPositionYIndexDefaultValue45: number = this.knobPositionYIndexDefaultValue44;

  private readonly knobPositionXIndexMinValue45: number = this.knobPositionXIndexMinValue44;
  private readonly knobPositionXIndexMaxValue45: number = this.knobPositionXIndexMaxValue44;
  private readonly knobPositionYIndexMinValue45: number = this.knobPositionYIndexMinValue44;
  private readonly knobPositionYIndexMaxValue45: number = this.knobPositionYIndexMaxValue44;

  private readonly knobPositionXIndexStepValue45: number = this.knobPositionXIndexStepValue44;
  private readonly knobPositionYIndexStepValue45: number = this.knobPositionYIndexStepValue44;

  private readonly knobPositionXIndexRangeValue45: number = this.knobPositionXIndexRangeValue44;
  private readonly knobPositionYIndexRangeValue45: number = this.knobPositionYIndexRangeValue44;

  private readonly knobPositionXIndexDefaultValue46: number = this.knobPositionXIndexDefaultValue45;
  private readonly knobPositionYIndexDefaultValue46: number = this.knobPositionYIndexDefaultValue45;

  private readonly knobPositionXIndexMinValue46: number = this.knobPositionXIndexMinValue45;
  private readonly knobPositionXIndexMaxValue46: number = this.knobPositionXIndexMaxValue45;
  private readonly knobPositionYIndexMinValue46: number = this.knobPositionYIndexMinValue45;
  private readonly knobPositionYIndexMaxValue46: number = this.knobPositionYIndexMaxValue45;

  private readonly knobPositionXIndexStepValue46: number = this.knobPositionXIndexStepValue45;
  private readonly knobPositionYIndexStepValue46: number = this.knobPositionYIndexStepValue45;

  private readonly knobPositionXIndexRangeValue46: number = this.knobPositionXIndexRangeValue45;
  private readonly knobPositionYIndexRangeValue46: number = this.knobPositionYIndexRangeValue45;

  private readonly knobPositionXIndexDefaultValue47: number = this.knobPositionXIndexDefaultValue46;
  private readonly knobPositionYIndexDefaultValue47: number = this.knobPositionYIndexDefaultValue46;

  private readonly knobPositionXIndexMinValue47: number = this.knobPositionXIndexMinValue46;
  private readonly knobPositionXIndexMaxValue47: number = this.knobPositionXIndexMaxValue46;
  private readonly knobPositionYIndexMinValue47: number = this.knobPositionYIndexMinValue46;
  private readonly knobPositionYIndexMaxValue47: number = this.knobPositionYIndexMaxValue46;

  private readonly knobPositionXIndexStepValue47: number = this.knobPositionXIndexStepValue46;
  private readonly knobPositionYIndexStepValue47: number = this.knobPositionYIndexStepValue46;

  private readonly knobPositionXIndexRangeValue47: number = this.knobPositionXIndexRangeValue46;
  private readonly knobPositionYIndexRangeValue47: number = this.knobPositionYIndexRangeValue46;

  private readonly knobPositionXIndexDefaultValue48: number = this.knobPositionXIndexDefaultValue47;
  private readonly knobPositionYIndexDefaultValue48: number = this.knobPositionYIndexDefaultValue47;

  private readonly knobPositionXIndexMinValue48: number = this.knobPositionXIndexMinValue47;
  private readonly knobPositionXIndexMaxValue48: number = this.knobPositionXIndexMaxValue47;
  private readonly knobPositionYIndexMinValue48: number = this.knobPositionYIndexMinValue47;
  private readonly knobPositionYIndexMaxValue48: number = this.knobPositionYIndexMaxValue47;

  private readonly knobPositionXIndexStepValue48: number = this.knobPositionXIndexStepValue47;
  private readonly knobPositionYIndexStepValue48: number = this.knobPositionYIndexStepValue47;

  private readonly knobPositionXIndexRangeValue48: number = this.knobPositionXIndexRangeValue47;
  private readonly knobPositionYIndexRangeValue48: number = this.knobPositionYIndexRangeValue47;

  private readonly knobPositionXIndexDefaultValue49: number = this.knobPositionXIndexDefaultValue48;
  private readonly knobPositionYIndexDefaultValue49: number = this.knobPositionYIndexDefaultValue48;

  private readonly knobPositionXIndexMinValue49: number = this.knobPositionXIndexMinValue48;
  private readonly knobPositionXIndexMaxValue49: number = this.knobPositionXIndexMaxValue48;
  private readonly knobPositionYIndexMinValue49: number = this.knobPositionYIndexMinValue48;
  private readonly knobPositionYIndexMaxValue49: number = this.knobPositionYIndexMaxValue48;

  private readonly knobPositionXIndexStepValue49: number = this.knobPositionXIndexStepValue48;
  private readonly knobPositionYIndexStepValue49: number = this.knobPositionYIndexStepValue48;

  private readonly knobPositionXIndexRangeValue49: number = this.knobPositionXIndexRangeValue48;
  private readonly knobPositionYIndexRangeValue49: number = this.knobPositionYIndexRangeValue48;

  private readonly knobPositionXIndexDefaultValue50: number = this.knobPositionXIndexDefaultValue49;
  private readonly knobPositionYIndexDefaultValue50: number = this.knobPositionYIndexDefaultValue49;

  private readonly knobPositionXIndexMinValue50: number = this.knobPositionXIndexMinValue49;
  private readonly knobPositionXIndexMaxValue50: number = this.knobPositionXIndexMaxValue49;
  private readonly knobPositionYIndexMinValue50: number = this.knobPositionYIndexMinValue49;
  private readonly knobPositionYIndexMaxValue50: number = this.knobPositionYIndexMaxValue49;

  private readonly knobPositionXIndexStepValue50: number = this.knobPositionXIndexStepValue49;
  private readonly knobPositionYIndexStepValue50: number = this.knobPositionYIndexStepValue49;

  private readonly knobPositionXIndexRangeValue50: number = this.knobPositionXIndexRangeValue49;
  private readonly knobPositionYIndexRangeValue50: number = this.knobPositionYIndexRangeValue49;

  private readonly knobPositionXIndexDefaultValue51: number = this.knobPositionXIndexDefaultValue50;
  private readonly knobPositionYIndexDefaultValue51: number = this.knobPositionYIndexDefaultValue50;

  private readonly knobPositionXIndexMinValue51: number = this.knobPositionXIndexMinValue50;
  private readonly knobPositionXIndexMaxValue51: number = this.knobPositionXIndexMaxValue50;
  private readonly knobPositionYIndexMinValue51: number = this.knobPositionYIndexMinValue50;
  private readonly knobPositionYIndexMaxValue51: number = this.knobPositionYIndexMaxValue50;

  private readonly knobPositionXIndexStepValue51: number = this.knobPositionXIndexStepValue50;
  private readonly knobPositionYIndexStepValue51: number = this.knobPositionYIndexStepValue50;

  private readonly knobPositionXIndexRangeValue51: number = this.knobPositionXIndexRangeValue50;
  private readonly knobPositionYIndexRangeValue51: number = this.knobPositionYIndexRangeValue50;

  private readonly knobPositionXIndexDefaultValue52: number = this.knobPositionXIndexDefaultValue51;
  private readonly knobPositionYIndexDefaultValue52: number = this.knobPositionYIndexDefaultValue51;

  private readonly knobPositionXIndexMinValue52: number = this.knobPositionXIndexMinValue51;
  private readonly knobPositionXIndexMaxValue52: number = this.knobPositionXIndexMaxValue51;
  private readonly knobPositionYIndexMinValue52: number = this.knobPositionYIndexMinValue51;
  private readonly knobPositionYIndexMaxValue52: number = this.knobPositionYIndexMaxValue51;

  private readonly knobPositionXIndexStepValue52: number = this.knobPositionXIndexStepValue51;
  private readonly knobPositionYIndexStepValue52: number = this.knobPositionYIndexStepValue51;

  private readonly knobPositionXIndexRangeValue52: number = this.knobPositionXIndexRangeValue51;
  private readonly knobPositionYIndexRangeValue52: number = this.knobPositionYIndexRangeValue51;

  private readonly knobPositionXIndexDefaultValue53: number = this.knobPositionXIndexDefaultValue52;
  private readonly knobPositionYIndexDefaultValue53: number = this.knobPositionYIndexDefaultValue52;

  private readonly knobPositionXIndexMinValue53: number = this.knobPositionXIndexMinValue52;
  private readonly knobPositionXIndexMaxValue53: number = this.knobPositionXIndexMaxValue52;
  private readonly knobPositionYIndexMinValue53: number = this.knobPositionYIndexMinValue52;
  private readonly knobPositionYIndexMaxValue53: number = this.knobPositionYIndexMaxValue52;

  private readonly knobPositionXIndexStepValue53: number = this.knobPositionXIndexStepValue52;
  private readonly knobPositionYIndexStepValue53: number = this.knobPositionYIndexStepValue52;

  private readonly knobPositionXIndexRangeValue53: number = this.knobPositionXIndexRangeValue52;
  private readonly knobPositionYIndexRangeValue53: number = this.knobPositionYIndexRangeValue52;

  private readonly knobPositionXIndexDefaultValue54: number = this.knobPositionXIndexDefaultValue53;
  private readonly knobPositionYIndexDefaultValue54: number = this.knobPositionYIndexDefaultValue53;

  private readonly knobPositionXIndexMinValue54: number = this.knobPositionXIndexMinValue53;
  private readonly knobPositionXIndexMaxValue54: number = this.knobPositionXIndexMaxValue53;
  private readonly knobPositionYIndexMinValue54: number = this.knobPositionYIndexMinValue53;
  private readonly knobPositionYIndexMaxValue54: number = this.knobPositionYIndexMaxValue53;

  private readonly knobPositionXIndexStepValue54: number = this.knobPositionXIndexStepValue53;
  private readonly knobPositionYIndexStepValue54: number = this.knobPositionYIndexStepValue53;

  private readonly knobPositionXIndexRangeValue54: number = this.knobPositionXIndexRangeValue53;
  private readonly knobPositionYIndexRangeValue54: number = this.knobPositionYIndexRangeValue53;

  private readonly knobPositionXIndexDefaultValue55: number = this.knobPositionXIndexDefaultValue54;
  private readonly knobPositionYIndexDefaultValue55: number = this.knobPositionYIndexDefaultValue54;

  private readonly knobPositionXIndexMinValue55: number = this.knobPositionXIndexMinValue54;
  private readonly knobPositionXIndexMaxValue55: number = this.knobPositionXIndexMaxValue54;
  private readonly knobPositionYIndexMinValue55: number = this.knobPositionYIndexMinValue54;
  private readonly knobPositionYIndexMaxValue55: number = this.knobPositionYIndexMaxValue54;

  private readonly knobPositionXIndexStepValue55: number = this.knobPositionXIndexStepValue54;
  private readonly knobPositionYIndexStepValue55: number = this.knobPositionYIndexStepValue54;

  private readonly knobPositionXIndexRangeValue55: number = this.knobPositionXIndexRangeValue54;
  private readonly knobPositionYIndexRangeValue55: number = this.knobPositionYIndexRangeValue54;

  private readonly knobPositionXIndexDefaultValue56: number = this.knobPositionXIndexDefaultValue55;
  private readonly knobPositionYIndexDefaultValue56: number = this.knobPositionYIndexDefaultValue55;

  private readonly knobPositionXIndexMinValue56: number = this.knobPositionXIndexMinValue55;
  private readonly knobPositionXIndexMaxValue56: number = this.knobPositionXIndexMaxValue55;
  private readonly knobPositionYIndexMinValue56: number = this.knobPositionYIndexMinValue55;
  private readonly knobPositionYIndexMaxValue56: number = this.knobPositionYIndexMaxValue55;

  private readonly knobPositionXIndexStepValue56: number = this.knobPositionXIndexStepValue55;
  private readonly knobPositionYIndexStepValue56: number = this.knobPositionYIndexStepValue55;

  private readonly knobPositionXIndexRangeValue56: number = this.knobPositionXIndexRangeValue55;
  private readonly knobPositionYIndexRangeValue56: number = this.knobPositionYIndexRangeValue55;

  private readonly knobPositionXIndexDefaultValue57: number = this.knobPositionXIndexDefaultValue56;
  private readonly knobPositionYIndexDefaultValue57: number = this.knobPositionYIndexDefaultValue56;

  private readonly knobPositionXIndexMinValue57: number = this.knobPositionXIndexMinValue56;
  private readonly knobPositionXIndexMaxValue57: number = this.knobPositionXIndexMaxValue56;
  private readonly knobPositionYIndexMinValue57: number = this.knobPositionYIndexMinValue56;
  private readonly knobPositionYIndexMaxValue57: number = this.knobPositionYIndexMaxValue56;

  private readonly knobPositionXIndexStepValue57: number = this.knobPositionXIndexStepValue56;
  private readonly knobPositionYIndexStepValue57: number = this.knobPositionYIndexStepValue56;

  private readonly knobPositionXIndexRangeValue57: number = this.knobPositionXIndexRangeValue56;
  private readonly knobPositionYIndexRangeValue57: number = this.knobPositionYIndexRangeValue56;

  private readonly knobPositionXIndexDefaultValue58: number = this.knobPositionXIndexDefaultValue57;
  private readonly knobPositionYIndexDefaultValue58: number = this.knobPositionYIndexDefaultValue57;

  private readonly knobPositionXIndexMinValue58: number = this.knobPositionXIndexMinValue57;
  private readonly knobPositionXIndexMaxValue58: number = this.knobPositionXIndexMaxValue57;
  private readonly knobPositionYIndexMinValue58: number = this.knobPositionYIndexMinValue57;
  private readonly knobPositionYIndexMaxValue58: number = this.knobPositionYIndexMaxValue57;

  private readonly knobPositionXIndexStepValue58: number = this.knobPositionXIndexStepValue57;
  private readonly knobPositionYIndexStepValue58: number = this.knobPositionYIndexStepValue57;

  private readonly knobPositionXIndexRangeValue58: number = this.knobPositionXIndexRangeValue57;
  private readonly knobPositionYIndexRangeValue58: number = this.knobPositionYIndexRangeValue57;

  private readonly knobPositionXIndexDefaultValue59: number = this.knobPositionXIndexDefaultValue58;
  private readonly knobPositionYIndexDefaultValue59: number = this.knobPositionYIndexDefaultValue58;

  private readonly knobPositionXIndexMinValue59: number = this.knobPositionXIndexMinValue58;
  private readonly knobPositionXIndexMaxValue59: number = this.knobPositionXIndexMaxValue58;
  private readonly knobPositionYIndexMinValue59: number = this.knobPositionYIndexMinValue58;
  private readonly knobPositionYIndexMaxValue59: number = this.knobPositionYIndexMaxValue58;

  private readonly knobPositionXIndexStepValue59: number = this.knobPositionXIndexStepValue58;
  private readonly knobPositionYIndexStepValue59: number = this.knobPositionYIndexStepValue58;

  private readonly knobPositionXIndexRangeValue59: number = this.knobPositionXIndexRangeValue58;
  private readonly knobPositionYIndexRangeValue59: number = this.knobPositionYIndexRangeValue58;

  private readonly knobPositionXIndexDefaultValue60: number = this.knobPositionXIndexDefaultValue59;
  private readonly knobPositionYIndexDefaultValue60: number = this.knobPositionYIndexDefaultValue59;

  private readonly knobPositionXIndexMinValue60: number = this.knobPositionXIndexMinValue59;
  private readonly knobPositionXIndexMaxValue60: number = this.knobPositionXIndexMaxValue59;
  private readonly knobPositionYIndexMinValue60: number = this.knobPositionYIndexMinValue59;
  private readonly knobPositionYIndexMaxValue60: number = this.knobPositionYIndexMaxValue59;

  private readonly knobPositionXIndexStepValue60: number = this.knobPositionXIndexStepValue59;
  private readonly knobPositionYIndexStepValue60: number = this.knobPositionYIndexStepValue59;

  private readonly knobPositionXIndexRangeValue60: number = this.knobPositionXIndexRangeValue59;
  private readonly knobPositionYIndexRangeValue60: number = this.knobPositionYIndexRangeValue59;

  private readonly knobPositionXIndexDefaultValue61: number = this.knobPositionXIndexDefaultValue60;
  private readonly knobPositionYIndexDefaultValue61: number = this.knobPositionYIndexDefaultValue60;

  private readonly knobPositionXIndexMinValue61: number = this.knobPositionXIndexMinValue60;
  private readonly knobPositionXIndexMaxValue61: number = this.knobPositionXIndexMaxValue60;
  private readonly knobPositionYIndexMinValue61: number = this.knobPositionYIndexMinValue60;
  private readonly knobPositionYIndexMaxValue61: number = this.knobPositionYIndexMaxValue60;

  private readonly knobPositionXIndexStepValue61: number = this.knobPositionXIndexStepValue60;
  private readonly knobPositionYIndexStepValue61: number = this.knobPositionYIndexStepValue60;

  private readonly knobPositionXIndexRangeValue61: number = this.knobPositionXIndexRangeValue60;
  private readonly knobPositionYIndexRangeValue61: number = this.knobPositionYIndexRangeValue60;

  private readonly knobPositionXIndexDefaultValue62: number = this.knobPositionXIndexDefaultValue61;
  private readonly knobPositionYIndexDefaultValue62: number = this.knobPositionYIndexDefaultValue61;

  private readonly knobPositionXIndexMinValue62: number = this.knobPositionXIndexMinValue61;
  private readonly knobPositionXIndexMaxValue62: number = this.knobPositionXIndexMaxValue61;
  private readonly knobPositionYIndexMinValue62: number = this.knobPositionYIndexMinValue61;
  private readonly knobPositionYIndexMaxValue62: number = this.knobPositionYIndexMaxValue61;

  private readonly knobPositionXIndexStepValue62: number = this.knobPositionXIndexStepValue61;
  private readonly knobPositionYIndexStepValue62: number = this.knobPositionYIndexStepValue61;

  private readonly knobPositionXIndexRangeValue62: number = this.knobPositionXIndexRangeValue61;
  private readonly knobPositionYIndexRangeValue62: number = this.knobPositionYIndexRangeValue61;

  private readonly knobPositionXIndexDefaultValue63: number = this.knobPositionXIndexDefaultValue62;
  private readonly knobPositionYIndexDefaultValue63: number = this.knobPositionYIndexDefaultValue62;

  private readonly knobPositionXIndexMinValue63: number = this.knobPositionXIndexMinValue62;
  private readonly knobPositionXIndexMaxValue63: number = this.knobPositionXIndexMaxValue62;
  private readonly knobPositionYIndexMinValue63: number = this.knobPositionYIndexMinValue62;
  private readonly knobPositionYIndexMaxValue63: number = this.knobPositionYIndexMaxValue62;

  private readonly knobPositionXIndexStepValue63: number = this.knobPositionXIndexStepValue62;
  private readonly knobPositionYIndexStepValue63: number = this.knobPositionYIndexStepValue62;

  private readonly knobPositionXIndexRangeValue63: number = this.knobPositionXIndexRangeValue62;
  private readonly knobPositionYIndexRangeValue63: number = this.knobPositionYIndexRangeValue62;

  private readonly knobPositionXIndexDefaultValue64: number = this.knobPositionXIndexDefaultValue63;
  private readonly knobPositionYIndexDefaultValue64: number = this.knobPositionYIndexDefaultValue63;

  private readonly knobPositionXIndexMinValue64: number = this.knobPositionXIndexMinValue63;
  private readonly knobPositionXIndexMaxValue64: number = this.knobPositionXIndexMaxValue63;
  private readonly knobPositionYIndexMinValue64: number = this.knobPositionYIndexMinValue63;
  private readonly knobPositionYIndexMaxValue64: number = this.knobPositionYIndexMaxValue63;

  private readonly knobPositionXIndexStepValue64: number = this.knobPositionXIndexStepValue63;
  private readonly knobPositionYIndexStepValue64: number = this.knobPositionYIndexStepValue63;

  private readonly knobPositionXIndexRangeValue64: number = this.knobPositionXIndexRangeValue63;
  private readonly knobPositionYIndexRangeValue64: number = this.knobPositionYIndexRangeValue63;

  private readonly knobPositionXIndexDefaultValue65: number = this.knobPositionXIndexDefaultValue64;
  private readonly knobPositionYIndexDefaultValue65: