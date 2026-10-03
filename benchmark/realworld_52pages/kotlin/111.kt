/*
 * Copyright (c) 2023 Samson Achiaga
 *
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

package com.certified.audionote.ui

import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.Context
import android.content.Intent
import android.media.MediaPlayer
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.DatePicker
import android.widget.TimePicker
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.content.FileProvider
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.certified.audionote.R
import com.certified.audionote.databinding.DialogEditReminderBinding
import com.certified.audionote.model.Note
import com.certified.audionote.utils.Extensions.safeNavigate
import com.certified.audionote.utils.Extensions.showToast
import com.certified.audionote.utils.ReminderAvailableState
import com.certified.audionote.utils.ReminderCompletionState
import com.certified.audionote.utils.cancelAlarm
import com.certified.audionote.utils.currentDate
import com.certified.audionote.utils.formatReminderDate
import com.certified.audionote.utils.startAlarm
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timerx.Stopwatch
import timerx.Timer
import timerx.TimerBuilder
import java.io.File
import java.io.IOException
import java.util.Calendar
import java.util.concurrent.TimeUnit

private val TextBlack = Color(0xFF000000)
private val FabColor = Color(0xFFEFB8C8)

@AndroidEntryPoint
class EditNoteFragment : Fragment(), DatePickerDialog.OnDateSetListener,
    TimePickerDialog.OnTimeSetListener {

    private val viewModel: NotesViewModel by viewModels()
    private lateinit var navController: NavController

    private val args: EditNoteFragmentArgs by navArgs()
    private lateinit var _note: Note
    private var isPlayingRecord = false
    private var pickedDateTime: Calendar? = null
    private val currentDateTime by lazy { currentDate() }
    private var mediaPlayer: MediaPlayer? = null
    private var file: File? = null
    private var stopWatch: Stopwatch? = null
    private var timer: Timer? = null

    private var titleText = mutableStateOf("")
    private var descriptionText = mutableStateOf("")
    private var timerText = mutableStateOf("00:00")
    private var reminderText = mutableStateOf<String?>(null)
    private var hasReminder = mutableStateOf(false)
    private var reminderCompleted = mutableStateOf(false)
    private var noteColor = mutableStateOf(Color(0xFFFFECF1))

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _note = args.note ?: Note()
        titleText.value = _note.title
        descriptionText.value = _note.description
        noteColor.value = Color(_note.color)
        hasReminder.value = _note.reminder != null
        reminderText.value = _note.reminder?.let { formatReminderDate(it) }

        timerText.value = if (_note.audioLength > 0) {
            val min = _note.audioLength / 60
            val sec = _note.audioLength % 60
            String.format("%02d:%02d", min, sec)
        } else "00:00"

        lifecycleScope.launch(Dispatchers.IO) {
            file = File(_note.filePath)
        }

        viewModel.apply {
            if (_note.reminder != null) {
                _reminderAvailableState.value = ReminderAvailableState.HAS_REMINDER
                if (currentDate().timeInMillis > args.note.reminder!!) {
                    _reminderCompletionState.value = ReminderCompletionState.COMPLETED
                    reminderCompleted.value = true
                } else {
                    _reminderCompletionState.value = ReminderCompletionState.ONGOING
                }
            }
        }

        return ComposeView(requireContext()).apply {
            setContent {
                MaterialTheme {
                    EditNoteScreen(
                        noteColor = noteColor.value,
                        title = titleText.value,
                        onTitleChange = { titleText.value = it },
                        description = descriptionText.value,
                        onDescriptionChange = { descriptionText.value = it },
                        timerDisplay = timerText.value,
                        isPlaying = isPlayingRecord,
                        hasReminder = hasReminder.value,
                        reminderDate = reminderText.value,
                        reminderCompleted = reminderCompleted.value,
                        onBackClick = {
                            navController.safeNavigate(
                                EditNoteFragmentDirections.actionEditNoteFragmentToHomeFragment()
                            )
                        },
                        onShareClick = { shareNote() },
                        onDeleteClick = { launchDeleteNoteDialog(requireContext()) },
                        onPlayClick = { playPauseRecord() },
                        onSaveClick = { updateNote() },
                        onReminderClick = {
                            if (viewModel.reminderAvailableState.value == ReminderAvailableState.NO_REMINDER)
                                pickDate()
                            else
                                openEditReminderDialog()
                        }
                    )
                }
            }
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        navController = Navigation.findNavController(view)
    }

    override fun onResume() {
        super.onResume()
        updateStatusBarColor(args.note.color)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        if (isPlayingRecord) mediaPlayer?.apply { stop(); release() }
        mediaPlayer = null
        timer?.apply { stop(); reset() }
        timer = null
        stopWatch?.apply { stop(); reset() }
        stopWatch = null
    }

    private fun playPauseRecord() {
        if (!isPlayingRecord) {
            isPlayingRecord = true
            if (timer == null) startPlayingRecording()
            else continuePlayingRecording()
        } else {
            if (timer?.getRemainingTimeIn(TimeUnit.SECONDS) != 0L) {
                pausePlayingRecording()
            } else {
                stopPlayingRecording()
            }
            isPlayingRecord = false
        }
    }

    private fun updateNote() {
        val note = _note.copy(
            title = titleText.value.trim(),
            description = descriptionText.value.trim(),
            lastModificationDate = currentDate().timeInMillis
        )
        if (note.title.isNotBlank()) {
            viewModel.updateNote(note)
            if (pickedDateTime?.timeInMillis != null && pickedDateTime?.timeInMillis != currentDateTime.timeInMillis)
                startAlarm(requireContext(), pickedDateTime!!.timeInMillis, note)
            navController.safeNavigate(EditNoteFragmentDirections.actionEditNoteFragmentToHomeFragment())
        } else {
            showToast(requireContext().getString(R.string.title_required))
        }
    }

    override fun onDateSet(p0: DatePicker?, p1: Int, p2: Int, p3: Int) {
        pickedDateTime = currentDate()
        pickedDateTime!!.set(p1, p2, p3)
        val hourOfDay = currentDateTime.get(Calendar.HOUR_OF_DAY)
        val minuteOfDay = currentDateTime.get(Calendar.MINUTE)
        val timePickerDialog = TimePickerDialog(requireContext(), this, hourOfDay, minuteOfDay, false)
        timePickerDialog.setOnDismissListener {
            viewModel._reminderAvailableState.value = ReminderAvailableState.HAS_REMINDER
            viewModel._reminderCompletionState.value = ReminderCompletionState.ONGOING
            _note.reminder = pickedDateTime!!.timeInMillis
            reminderText.value = formatReminderDate(pickedDateTime!!.timeInMillis)
            hasReminder.value = true
            reminderCompleted.value = false
        }
        timePickerDialog.show()
    }

    override fun onTimeSet(p0: TimePicker?, p1: Int, p2: Int) {
        pickedDateTime!!.set(Calendar.HOUR_OF_DAY, p1)
        pickedDateTime!!.set(Calendar.MINUTE, p2)
        if (pickedDateTime!!.timeInMillis <= currentDate().timeInMillis) {
            pickedDateTime!!.run {
                set(Calendar.DAY_OF_MONTH, currentDateTime.get(Calendar.DAY_OF_MONTH) + 1)
                set(Calendar.YEAR, currentDateTime.get(Calendar.YEAR))
                set(Calendar.MONTH, currentDateTime.get(Calendar.MONTH))
            }
        }
    }

    private fun pickDate() {
        val cal = currentDateTime
        val d = DatePickerDialog(requireContext(), this, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DAY_OF_MONTH))
        d.show()
    }

    private fun openEditReminderDialog() {
        val view = DialogEditReminderBinding.inflate(layoutInflater)
        val bottomSheetDialog = BottomSheetDialog(requireContext())
        view.apply {
            note = _note
            btnDeleteReminder.setOnClickListener {
                viewModel._reminderAvailableState.value = ReminderAvailableState.NO_REMINDER
                _note.reminder = null
                hasReminder.value = false
                reminderText.value = null
                cancelAlarm(requireContext(), _note.id)
                bottomSheetDialog.dismiss()
            }
            btnModifyReminder.setOnClickListener {
                bottomSheetDialog.dismiss()
                pickDate()
            }
        }
        bottomSheetDialog.edgeToEdgeEnabled
        bottomSheetDialog.setContentView(view.root)
        bottomSheetDialog.show()
    }

    private fun launchDeleteNoteDialog(context: Context) {
        MaterialAlertDialogBuilder(context).apply {
            setTitle(context.getString(R.string.delete_note))
            setMessage("${context.getString(R.string.confirm_deletion)} ${_note.title}?")
            setNegativeButton(context.getString(R.string.no)) { dialog, _ -> dialog?.dismiss() }
            setPositiveButton(context.getString(R.string.yes)) { _, _ ->
                viewModel.deleteNote(_note)
                lifecycleScope.launch(Dispatchers.IO) { file?.delete() }
                navController.safeNavigate(EditNoteFragmentDirections.actionEditNoteFragmentToHomeFragment())
            }
            show()
        }
    }

    private fun startPlayingRecording() {
        timer = TimerBuilder()
            .startTime(_note.audioLength, TimeUnit.SECONDS)
            .startFormat(if (_note.audioLength >= 3600000L) "HH:MM:SS" else "MM:SS")
            .onTick { time -> timerText.value = time }
            .actionWhen(0, TimeUnit.SECONDS) {
                isPlayingRecord = false
                stopPlayingRecording()
            }
            .build()
        mediaPlayer = MediaPlayer()
        try {
            mediaPlayer?.apply {
                setDataSource(file?.absolutePath)
                prepare()
                start()
            }
            timer!!.start()
        } catch (e: IOException) {
            e.printStackTrace()
            showToast(requireContext().getString(R.string.error_occurred))
        }
    }

    private fun pausePlayingRecording() {
        mediaPlayer?.pause()
        timer?.stop()
    }

    private fun continuePlayingRecording() {
        mediaPlayer?.start()
        timer?.start()
    }

    private fun stopPlayingRecording() {
        mediaPlayer?.apply { stop(); release() }
        timer?.apply { reset(); stop() }
        timer = null
    }

    private fun shareNote() {
        if (file == null) { showToast(requireContext().getString(R.string.file_not_found)); return }
        try {
            val uri = FileProvider.getUriForFile(requireContext(), "com.certified.audionote.provider", file!!)
            startActivity(Intent.createChooser(Intent(Intent.ACTION_SEND).apply {
                type = "*/*"; putExtra(Intent.EXTRA_STREAM, uri)
            }, "Share using"))
        } catch (t: Throwable) {
            showToast(requireContext().getString(R.string.error_occurred))
        }
    }

    private fun updateStatusBarColor(color: Int) {
        val window = requireActivity().window
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = color
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EditNoteScreen(
    noteColor: Color = Color(0xFFFFECF1),
    title: String = "",
    onTitleChange: (String) -> Unit = {},
    description: String = "",
    onDescriptionChange: (String) -> Unit = {},
    timerDisplay: String = "00:00",
    isPlaying: Boolean = false,
    hasReminder: Boolean = false,
    reminderDate: String? = null,
    reminderCompleted: Boolean = false,
    onBackClick: () -> Unit = {},
    onShareClick: () -> Unit = {},
    onDeleteClick: () -> Unit = {},
    onPlayClick: () -> Unit = {},
    onSaveClick: () -> Unit = {},
    onReminderClick: () -> Unit = {}
) {
    val scrollState = rememberScrollState()
    val isPreview = LocalInspectionMode.current

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(noteColor)
    ) {
        Column(modifier = Modifier.fillMaxSize()) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(start = 8.dp, top = 16.dp, end = 8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onBackClick) {
                    if (isPreview)
                        Icon(Icons.Default.ArrowBack, "Back", tint = TextBlack)
                    else
                        Icon(painterResource(id = R.drawable.ic_arrow_back_black_24dp), "Back", tint = TextBlack)
                }
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = "Edit Note",
                    style = MaterialTheme.typography.titleMedium.copy(fontWeight = FontWeight.Bold, fontSize = 18.sp),
                    color = TextBlack,
                    modifier = Modifier.weight(1f)
                )
                IconButton(onClick = onDeleteClick) {
                    if (isPreview)
                        Icon(Icons.Default.Delete, "Delete", tint = TextBlack)
                    else
                        Icon(painterResource(id = R.drawable.ic_delete_black_24dp), "Delete", tint = TextBlack)
                }
                IconButton(onClick = onShareClick) {
                    if (isPreview)
                        Icon(Icons.Default.Share, "Share", tint = TextBlack)
                    else
                        Icon(painterResource(id = R.drawable.ic_share_black_24dp), "Share", tint = TextBlack)
                }
            }

            Column(
                modifier = Modifier
                    .weight(1f)
                    .verticalScroll(scrollState)
                    .padding(horizontal = 16.dp, vertical = 16.dp)
            ) {
                OutlinedTextField(
                    value = title,
                    onValueChange = onTitleChange,
                    placeholder = { Text("Note title (required)", fontSize = 16.sp) },
                    modifier = Modifier.fillMaxWidth(),
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = Color.Transparent,
                        unfocusedBorderColor = Color.Transparent,
                        focusedContainerColor = Color.Transparent,
                        unfocusedContainerColor = Color.Transparent
                    ),
                    textStyle = MaterialTheme.typography.bodyLarge.copy(fontWeight = FontWeight.SemiBold, fontSize = 16.sp),
                    maxLines = 3
                )

                Spacer(modifier = Modifier.height(10.dp))

                OutlinedTextField(
                    value = description,
                    onValueChange = onDescriptionChange,
                    placeholder = { Text("Description", fontSize = 12.sp) },
                    modifier = Modifier.fillMaxWidth(),
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = Color.Transparent,
                        unfocusedBorderColor = Color.Transparent,
                        focusedContainerColor = Color.Transparent,
                        unfocusedContainerColor = Color.Transparent
                    ),
                    textStyle = MaterialTheme.typography.bodyMedium.copy(fontSize = 12.sp),
                    maxLines = 6
                )

                Spacer(modifier = Modifier.height(24.dp))

                Text(
                    text = timerDisplay,
                    style = MaterialTheme.typography.headlineMedium.copy(fontSize = 24.sp),
                    color = TextBlack,
                    modifier = Modifier.align(Alignment.CenterHorizontally)
                )

                Spacer(modifier = Modifier.height(16.dp))

                IconButton(
                    onClick = onPlayClick,
                    modifier = Modifier.align(Alignment.CenterHorizontally)
                ) {
                    if (isPreview) {
                        Icon(
                            imageVector = if (isPlaying) Icons.Default.Pause else Icons.Default.PlayArrow,
                            contentDescription = "Play/Pause",
                            modifier = Modifier.size(48.dp),
                            tint = TextBlack
                        )
                    } else {
                        Icon(
                            painter = painterResource(
                                id = if (isPlaying) R.drawable.ic_audio_playing else R.drawable.ic_audio_not_playing
                            ),
                            contentDescription = "Play/Pause",
                            modifier = Modifier.size(48.dp),
                            tint = TextBlack
                        )
                    }
                }
            }

            Card(
                modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp),
                colors = CardDefaults.cardColors(containerColor = Color.Transparent),
                onClick = onReminderClick
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(noteColor.copy(alpha = 0.15f))
                        .padding(horizontal = 12.dp, vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    if (isPreview) {
                        Icon(Icons.Default.Alarm, "Reminder", tint = TextBlack)
                    } else {
                        Icon(painterResource(id = R.drawable.ic_alarm_on_black_24dp), "Reminder", tint = TextBlack)
                    }
                    Spacer(modifier = Modifier.width(16.dp))
                    if (hasReminder && reminderDate != null) {
                        Text(
                            text = reminderDate,
                            style = MaterialTheme.typography.bodyMedium.copy(
                                fontSize = 14.sp,
                                textDecoration = if (reminderCompleted) TextDecoration.LineThrough else TextDecoration.None
                            ),
                            color = TextBlack
                        )
                    } else {
                        Text(
                            text = "Click to add a reminder to this note",
                            style = MaterialTheme.typography.bodyMedium.copy(fontSize = 12.sp),
                            color = TextBlack
                        )
                    }
                }
            }
        }
        FloatingActionButton(
            onClick = onSaveClick,
            modifier = Modifier
                .align(Alignment.BottomEnd)
                .padding(end = 16.dp, bottom = 72.dp),
            containerColor = FabColor,
            shape = RoundedCornerShape(16.dp)
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.padding(horizontal = 12.dp)
            ) {
                if (isPreview) {
                    Icon(Icons.Default.Done, "Save", tint = TextBlack, modifier = Modifier.size(20.dp))
                } else {
                    Icon(painterResource(id = R.drawable.ic_done_black_24dp), "Save", tint = TextBlack, modifier = Modifier.size(20.dp))
                }
                Spacer(modifier = Modifier.width(4.dp))
                Text("Save", color = TextBlack, fontWeight = FontWeight.SemiBold)
            }
        }
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewEditNoteScreen() {
    MaterialTheme {
        EditNoteScreen(
            title = "Meeting Notes",
            description = "Discussed Q3 roadmap...",
            timerDisplay = "02:15",
            isPlaying = true,
            hasReminder = true,
            reminderDate = "Jul 20, 2026 3:00 PM"
        )
    }
}
