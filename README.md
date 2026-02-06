# FPGA Computer Vision Pipeline

Real-time computer vision system implemented fully in RTL on FPGA. The design captures pixel data, performs hardware image preprocessing, stores a reduced feature tensor, detects the strongest activation (peak), and overlays the detected region back onto the video stream in real time via HDMI.

This project demonstrates a complete **streaming vision pipeline in hardware** including video timing, pixel processing, on-chip memory, feature extraction, and visualization — all without a CPU.

---

## System Overview

The pipeline operates fully in streaming fashion:

Video Source → Preprocess → Tensor Memory → Peak Detector → Overlay → HDMI Output

The system downsamples the incoming frame into a low-resolution tensor, computes intensity features, scans for the strongest activation, and visually highlights the detected region on the output display.

---

## Key Features

- Fully hardware-based computer vision pipeline (no processor)
- Real-time video processing using streaming architecture
- On-chip tensor memory for feature storage
- Peak detection engine for strongest feature localization
- Visual overlay of detected region on HDMI output
- Modular RTL design for extensibility (future CNN / ML acceleration)

---

## Module Descriptions

### `top.sv`
Top-level system integration. Connects video timing, preprocessing pipeline, tensor memory, peak detector, overlay, and HDMI output. Handles clocking, reset, switches, and overall dataflow between modules.

---

### `video_timing.sv`
Generates VGA/HDMI timing signals including:
- Pixel coordinates (x, y)
- Horizontal and vertical sync
- Video data enable (vde)
- Frame and line boundary signals

Defines the active video region and drives the pixel scan timing for the entire pipeline.

---

### `test_patterns.sv`
Generates synthetic video input for testing without a camera. Supports selectable pattern modes such as color bars and test visuals. Useful for validating the pipeline and display output.

---

### `preprocess.sv`
Image preprocessing and tensor generation stage.

Functions:
- Converts RGB pixel input to luminance/intensity
- Downsamples the full resolution frame into a low-resolution grid (tensor)
- Generates tensor write enable, address, and data
- Signals when a valid tensor frame is ready for processing

This module performs the **feature extraction stage** of the pipeline.

---

### `tensor_ram.sv`
On-chip memory storing the generated tensor.

- 1024 entries of signed 8-bit data
- Synchronous write and read interface
- Stores reduced feature map produced by preprocessing

Acts as the feature buffer for peak detection.

---

### `peak_detector.sv`
Scans the tensor memory to locate the strongest activation.

Functions:
- Sequentially reads tensor values
- Tracks maximum value and its location
- Outputs peak coordinates `(peak_u, peak_v)`
- Signals when detection is complete (`peak_ready`)

This module performs **hardware feature localization**.

---

### `overlay.sv`
Visualizes the detected peak on the output video.

Functions:
- Converts tensor coordinates to screen coordinates
- Draws a highlighted rectangular region over the detected area
- Blends overlay with base video stream

This provides real-time visual feedback of the detected feature.

---

## Hardware Architecture

- Streaming pixel pipeline (no frame buffering)
- Downsampled tensor representation (feature compression)
- Sequential peak scan engine
- Real-time overlay renderer
- Fully synchronous RTL design

---

## How It Works

1. Video timing generates pixel coordinates and sync signals.
2. Test pattern or camera provides RGB pixel stream.
3. Preprocess converts image to luminance and downsamples into a tensor.
4. Tensor is stored in on-chip RAM.
5. Peak detector scans tensor and finds strongest activation.
6. Overlay module highlights detected region on output video.
7. HDMI outputs processed video in real time.

---

## Applications

- Hardware computer vision pipelines
- FPGA machine learning preprocessing
- Real-time feature detection
- Embedded vision systems
- Foundation for hardware CNN / accelerator
- Robotics / tracking / object localization

---

## Future Improvements

- Camera input (OV7670 / HDMI capture)
- Convolution / CNN hardware accelerator
- Multi-peak detection
- Motion tracking
- Object detection pipeline
- Hardware ML inference engine
- AXI streaming / DMA integration
- Higher resolution tensor

---

## Author

Jashwanth Bamidi  
Electrical and Computer Engineering  
University of Illinois Urbana-Champaign  

Focus areas: FPGA, Computer Architecture, Embedded Systems, Hardware Acceleration, Digital Design

---
