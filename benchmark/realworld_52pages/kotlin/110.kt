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

import android.Manifest
import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.pm.PackageManager
import android.media.MediaRecorder
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.DatePicker
import android.widget.TimePicker
import androidx.activity.result.contract.ActivityResultContracts
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
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.fragment.navArgs
import com.certified.audionote.R
import com.certified.audionote.databinding.DialogEditReminderBinding
import com.certified.audionote.model.Note
import com.certified.audionote.utils.Extensions.safeNavigate
import com.certified.audionote.utils.Extensions.showKeyboardFor
import com.certified.audionote.utils.Extensions.showToast
import com.certified.audionote.utils.ReminderAvailableState
import com.certified.audionote.utils.currentDate
import com.certified.audionote.utils.filePath
import com.certified.audionote.utils.formatReminderDate
import com.certified.audionote.utils.roundOffDecimal
import com.certified.audionote.utils.startAlarm
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import dagger.hilt.android.AndroidEntryPoint
import timerx.Stopwatch
import timerx.StopwatchBuilder
import timerx.Timer
import java.io.File
import java.io.IOException
import java.util.Calendar
import java.util.concurrent.TimeUnit

private val TextWhite = Color.White
private val TextBlack = Color(0xFF000000)
private val FabColor = Color(0xFFEFB8C8)
private val ReminderOverlay = Color(0x27FFFFFF)

@AndroidEntryPoint
class AddNoteFragment : Fragment(), DatePickerDialog.OnDateSetListener,
    TimePickerDialog.OnTimeSetListener {

    private val viewModel: NotesViewModel by viewModels()
    private lateinit var navController: NavController

    private val args: EditNoteFragmentArgs by navArgs()
    private lateinit var _note: Note
    private var isRecording = false
    private var pickedDateTime: Calendar? = null
    private val currentDateTime by lazy { currentDate() }
    private var mediaRecorder: MediaRecorder? = null
    private var file: File? = null
    private var stopWatch: Stopwatch? = null
    private var timer: Timer? = null

    private var titleText = mutableStateOf("")
    private var descriptionText = mutableStateOf("")
    private var timerText = mutableStateOf("00:00")
    private var reminderText = mutableStateOf<String?>(null)
    private var hasReminder = mutableStateOf(false)
    private var noteColor = mutableStateOf(Color(0xFFFFECF1))

    private val requestAudioRecordingPermissionLauncher =
        registerForActivityResult(ActivityResultContracts.RequestPermission()) { isGranted ->
            if (!isGranted) MaterialAlertDialogBuilder(requireContext()).apply {
                setTitle(getString(R.string.audio_record_permission))
                setMessage(getString(R.string.permission_required))
                setPositiveButton(getString(R.string.ok)) { dialog, _ -> dialog.dismiss() }
                show()
            }
            else startRecording()
        }

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

        return ComposeView(requireContext()).apply {
            setContent {
                MaterialTheme {
                    AddNoteScreen(
                        noteColor = noteColor.value,
                        title = titleText.value,
                        onTitleChange = { titleText.value = it },
                        description = descriptionText.value,
                        onDescriptionChange = { descriptionText.value = it },
                        timerDisplay = timerText.value,
                        isRecording = isRecording,
                        hasReminder = hasReminder.value,
                        reminderDate = reminderText.value,
                        onBackClick = {
                            if (titleText.value.isNotBlank()) saveNote()
                            else try { file?.delete() } catch (_: Exception) {}
                            navController.safeNavigate(
                                AddNoteFragmentDirections.actionAddNoteFragmentToHomeFragment()
                            )
                        },
                        onRecordClick = { recordAudio() },
                        onSaveClick = {
                            if (titleText.value.isNotBlank()) saveNote()
                            else showToast(requireContext().getString(R.string.title_required))
                        },
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
        updateStatusBarColor(_note.color)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        mediaRecorder = null
        timer?.apply { stop(); reset() }
        timer = null
        stopWatch?.apply { stop(); reset() }
        stopWatch = null
    }

    private fun recordAudio() {
        if (!isRecording) {
            if (ContextCompat.checkSelfPermission(
                    requireContext(), Manifest.permission.RECORD_AUDIO
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                try { file?.delete() } catch (_: Exception) {}
                isRecording = true
                startRecording()
            } else if (shouldShowRequestPermissionRationale(Manifest.permission.RECORD_AUDIO))
                MaterialAlertDialogBuilder(requireContext()).apply {
                    setTitle(getString(R.string.audio_record_permission))
                    setMessage(getString(R.string.permission_required))
                    setPositiveButton(getString(R.string.ok)) { dialog, _ -> dialog.dismiss() }
                    show()
                }
            else requestAudioRecordingPermissionLauncher.launch(Manifest.permission.RECORD_AUDIO)
        } else {
            isRecording = false
            stopRecording()
        }
    }

    override fun onDateSet(p0: DatePicker?, p1: Int, p2: Int, p3: Int) {
        pickedDateTime = currentDate()
        pickedDateTime!!.set(p1, p2, p3)
        val hourOfDay = currentDateTime.get(Calendar.HOUR_OF_DAY)
        val minuteOfDay = currentDateTime.get(Calendar.MINUTE)
        val timePickerDialog =
            TimePickerDialog(requireContext(), this, hourOfDay, minuteOfDay, false)
        timePickerDialog.setOnDismissListener {
            viewModel._reminderAvailableState.value = ReminderAvailableState.HAS_REMINDER
            _note.reminder = pickedDateTime!!.timeInMillis
            reminderText.value = formatReminderDate(pickedDateTime!!.timeInMillis)
            hasReminder.value = true
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
        val startYear = currentDateTime.get(Calendar.YEAR)
        val startMonth = currentDateTime.get(Calendar.MONTH)
        val startDay = currentDateTime.get(Calendar.DAY_OF_MONTH)
        val datePickerDialog =
            DatePickerDialog(requireContext(), this, startYear, startMonth, startDay)
        datePickerDialog.show()
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

    private fun saveNote() {
        stopRecording()
        if (_note.audioLength <= 0) {
            showToast(requireContext().getString(R.string.record_note_before_saving))
            return
        }
        val note = _note.copy(
            title = titleText.value.trim(),
            description = descriptionText.value.trim()
        )
        viewModel.insertNote(note)
        showToast(requireContext().getString(R.string.note_saved))
        if (pickedDateTime?.timeInMillis != null && pickedDateTime!!.timeInMillis <= currentDateTime.timeInMillis)
            startAlarm(requireContext(), pickedDateTime!!.timeInMillis, note)
        navController.safeNavigate(AddNoteFragmentDirections.actionAddNoteFragmentToHomeFragment())
    }

    private fun startRecording() {
        val filePath = filePath(requireActivity())
        val fileName = "${System.currentTimeMillis()}.3gp"
        _note.filePath = "$filePath/$fileName"

        stopWatch = StopwatchBuilder()
            .startFormat("MM:SS")
            .onTick { time -> timerText.value = time }
            .changeFormatWhen(1, TimeUnit.HOURS, "HH:MM:SS")
            .build()

        mediaRecorder = MediaRecorder().apply {
            setAudioSource(MediaRecorder.AudioSource.MIC)
            setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP)
            setOutputFile("$filePath/$fileName")
            setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB)
            try {
                prepare()
                start()
                stopWatch!!.start()
                file = File("$filePath/$fileName")
            } catch (e: IOException) {
                showToast(requireContext().getString(R.string.error_occurred))
            }
        }
    }

    private fun stopRecording() {
        mediaRecorder?.apply { stop(); release() }
        mediaRecorder = null
        stopWatch?.apply {
            stop()
            _note.audioLength = stopWatch!!.getTimeIn(TimeUnit.SECONDS)
            reset()
        }
        stopWatch = null
        if (_note.audioLength <= 0) return
        file = File(_note.filePath)
        val fileByte = (file!!.readBytes().size.toDouble() / 1048576.00)
        _note.size = roundOffDecimal(fileByte)
    }

    private fun updateStatusBarColor(color: Int) {
        val window = requireActivity().window
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = color
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddNoteScreen(
    noteColor: Color = Color(0xFFFFECF1),
    title: String = "",
    onTitleChange: (String) -> Unit = {},
    description: String = "",
    onDescriptionChange: (String) -> Unit = {},
    timerDisplay: String = "00:00",
    isRecording: Boolean = false,
    hasReminder: Boolean = false,
    reminderDate: String? = null,
    onBackClick: () -> Unit = {},
    onRecordClick: () -> Unit = {},
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
                    .padding(start = 8.dp, top = 16.dp, end = 16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = onBackClick) {
                    if (isPreview) {
                        Icon(
                            imageVector = Icons.Default.ArrowBack,
                            contentDescription = "Back",
                            tint = TextBlack
                        )
                    } else {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_arrow_back_black_24dp),
                            contentDescription = "Back",
                            tint = TextBlack
                        )
                    }
                }
                Spacer(modifier = Modifier.width(8.dp))
                Text(
                    text = "New Note",
                    style = MaterialTheme.typography.titleMedium.copy(
                        fontWeight = FontWeight.Bold,
                        fontSize = 18.sp
                    ),
                    color = TextBlack
                )
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
                    textStyle = MaterialTheme.typography.bodyLarge.copy(
                        fontWeight = FontWeight.SemiBold,
                        fontSize = 16.sp
                    ),
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
                    style = MaterialTheme.typography.headlineMedium.copy(
                        fontSize = 24.sp
                    ),
                    color = TextBlack,
                    modifier = Modifier.align(Alignment.CenterHorizontally)
                )

                Spacer(modifier = Modifier.height(16.dp))

                IconButton(
                    onClick = onRecordClick,
                    modifier = Modifier.align(Alignment.CenterHorizontally)
                ) {
                    if (isPreview) {
                        Icon(
                            imageVector = if (isRecording) Icons.Default.FiberManualRecord else Icons.Default.Mic,
                            contentDescription = "Record",
                            modifier = Modifier.size(48.dp),
                            tint = TextBlack
                        )
                    } else {
                        Icon(
                            painter = painterResource(
                                id = if (isRecording) R.drawable.ic_mic_recording
                                else R.drawable.ic_mic_not_recording
                            ),
                            contentDescription = "Record",
                            modifier = Modifier.size(48.dp),
                            tint = TextBlack
                        )
                    }
                }
            }

            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
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
                        Icon(
                            imageVector = Icons.Default.Alarm,
                            contentDescription = "Reminder",
                            tint = TextBlack
                        )
                    } else {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_alarm_on_black_24dp),
                            contentDescription = "Reminder",
                            tint = TextBlack
                        )
                    }
                    Spacer(modifier = Modifier.width(16.dp))
                    if (hasReminder && reminderDate != null) {
                        Text(
                            text = reminderDate,
                            style = MaterialTheme.typography.bodyMedium.copy(fontSize = 14.sp),
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
                    Icon(
                        imageVector = Icons.Default.Done,
                        contentDescription = "Save",
                        tint = TextBlack,
                        modifier = Modifier.size(20.dp)
                    )
                } else {
                    Icon(
                        painter = painterResource(id = R.drawable.ic_done_black_24dp),
                        contentDescription = "Save",
                        tint = TextBlack,
                        modifier = Modifier.size(20.dp)
                    )
                }
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = "Save",
                    color = TextBlack,
                    fontWeight = FontWeight.SemiBold
                )
            }
        }
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewAddNoteScreen() {
    MaterialTheme {
        AddNoteScreen(
            timerDisplay = "01:23",
            hasReminder = true,
            reminderDate = "Jul 20, 2026 3:00 PM"

        )
    }
}
