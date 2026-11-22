/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { FlutterPlugin, FlutterPluginBinding, MethodChannel, } from '@ohos/flutter_ohos';
import AbilityAware from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityAware';
import { AbilityPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityPluginBinding';
import { MethodCallHandlerImpl } from './MethodCallHandlerImpl';

export default class RecordOhosPlugin implements FlutterPlugin, AbilityAware {
  private readonly MESSAGES_CHANNEL = 'com.llfbandit.record/messages';
  private channel: MethodChannel | null = null;
  private handler: MethodCallHandlerImpl | null = null;

  getUniqueClassName(): string {
    return "RecordOhosPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), this.MESSAGES_CHANNEL);
    this.handler = new MethodCallHandlerImpl(binding.getBinaryMessenger(), binding.getApplicationContext());
    this.channel.setMethodCallHandler(this.handler);
  }

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.handler?.setAbilityContext(binding.getAbility().context);
  }

  onDetachedFromAbility(): void {
    this.handler?.setAbilityContext(null);
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
      this.channel = null;
    }
    this.handler?.dispose();
    this.handler = null;
  }
}
