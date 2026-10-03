// entry/src/main/ets/viewmodel/RetroMusicPlayerViewModel.ets

import { BusinessError } from '@kit.BasicServicesKit';

export class RetroMusicPlayerViewModel {
  private _knobX: number = 140;
  private _knobY: number = 140;
  private _isDragging: boolean = false;
  
  get knobX(): number { return this._knobX; }
  set knobX(value: number) { this._knobX = value; }
  
  get knobY(): number { return this._knobY; }
  set knobY(value: number) { this._knobY = value; }
  
  get isDragging(): boolean { return this._isDragging; }
  set isDragging(value: boolean) { this._isDragging = value; }
}